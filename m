Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274982AbTHGCZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275061AbTHGCZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:25:57 -0400
Received: from ns.abs-comptech.com ([66.93.61.117]:39908 "EHLO
	ns.ABS-CompTech.com") by vger.kernel.org with ESMTP id S274982AbTHGCZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:25:56 -0400
Message-ID: <3F31B8AC.1070102@ABS-CompTech.com>
Date: Wed, 06 Aug 2003 22:25:48 -0400
From: "Albert E. Whale, CISSP" <aewhale@ABS-CompTech.com>
Reply-To: aewhale@No-JunkMail.com
Organization: ABS Computer Technology, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Question - from non-subscriber
References: <965253710F1@vcnet.vc.cvut.cz>
In-Reply-To: <965253710F1@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SPAM-Checked-by: www.No-JunkMail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Vandrovec wrote:

>On  6 Aug 03 at 16:59, Albert E. Whale, CISSP wrote:
>  
>
>nwfs can be used for this. ncpfs is for connecting to the live server,
>and you apparently do not have live server, if I understand it correctly.
> 
>
Yes it appears that I need nwfs to mount this disc.

>What's wrong with installing NetWare and accessing data through netware? 
>I think that it is simplest way to go. 
>  
>
My intent is to read the Inodes of the Filesystem to recover any lost 
and or previously deleted data.  My server for this operation is Linux 
based.  Installing Netware my mount the disc, but I still need to read 
it via Linux.

>If netware cannot mount the disk, then nwfs will not mount
>it too. Besides that nwfs is unmaintained - or at least I do not know
>where updated code lives.
>                                                Best regards,
>                                                    Petr Vandrovec
>                                                    vandrove@vc.cvut.cz
>                                                  
>
Herein lies my problem.  Nwfs is no longer maintained.

-- 
Albert E. Whale, CISSP
http://www.abs-comptech.com
----------------------------------------------------------------------
ABS Computer Technology, Inc. - ESM, Computer & Networking Specialists
Sr. Security, Network, and Systems Consultant
Founding Board of Directors of Pittsburgh FBI - InfraGard



