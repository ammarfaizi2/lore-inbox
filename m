Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTLaNEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbTLaNEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:04:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264890AbTLaNET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:04:19 -0500
Message-ID: <3FF2C93F.2080908@pobox.com>
Date: Wed, 31 Dec 2003 08:03:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-rc1-mm1
References: <20031231004725.535a89e4.akpm@osdl.org>
In-Reply-To: <20031231004725.535a89e4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-rc1/2.6.0-rc1-mm1/
> 
> 
> A few small additions, but mainly a resync with mainline.
> 
> 
> 
> 
> Changes since 2.6.0-mm2:
> 
> 
> -2.6.0-netdrvr-exp3.patch
> -2.6.0-netdrvr-exp3-fix.patch
> -Space_c-warning-fix.patch
> -via-rhine-netpoll-support.patch
> +2.6.0-bk2-netdrvr-exp1.patch


Argh, I missed a bonding build fix, and warning fix...  Plus rediffed 
against 2.6.0-rc1:

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-rc1-netdrvr-exp1.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-rc1-netdrvr-exp1.log

Have another big batch from Al Viro pending, with yet-more fixes from 
his audits...

	Jeff



