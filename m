Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTLRBiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 20:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbTLRBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 20:38:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43462 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264899AbTLRBit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 20:38:49 -0500
Message-ID: <3FE1051B.3060104@pobox.com>
Date: Wed, 17 Dec 2003 20:38:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux.nics@intel.com
Subject: Re: [BK PATCHES] 2.6.x experimental net driver updates
References: <3FDEA6FA.4010906@pobox.com> <20031218013145.GG25717@fs.tum.de>
In-Reply-To: <20031218013145.GG25717@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi Jeff,
> 
> I got the following compile error when trying to compile e100 statically 
> into a kernel using gcc 2.95:


This is fixed in the updated patch:

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp2.patch.bz2

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp2.log

Thanks,

	Jeff



