Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCQO64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUCQO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:58:56 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:27657 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261673AbUCQO6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:58:55 -0500
Message-ID: <405867B6.1030107@aitel.hist.no>
Date: Wed, 17 Mar 2004 15:59:02 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1 reboots before the boot completes
References: <20040316015338.39e2c48e.akpm@osdl.org>	<405823B2.7070500@aitel.hist.no> <20040317021531.70191854.akpm@osdl.org>
In-Reply-To: <20040317021531.70191854.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
>> 2.6.5-rc1-mm1 didn't come up for me.
> 
> 
> yes, there's something bad in there.
> 
> Does it help if you revert ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/early-x86-cpu-detection-fix.patch ?

That did the trick, now posting from 2.6.5-rc1-mm1 :-)

Helge Hafting

