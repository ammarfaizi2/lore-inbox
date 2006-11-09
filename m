Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424147AbWKIRKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424147AbWKIRKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424143AbWKIRJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:09:59 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:30165 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1424140AbWKIRJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:09:58 -0500
Message-ID: <455360CF.9070600@cfl.rr.com>
Date: Thu, 09 Nov 2006 12:09:35 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Jano <jasieczek@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com> <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com> <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
In-Reply-To: <45534D2C.6080509@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 17:09:33.0533 (UTC) FILETIME=[D3B058D0:01C70421]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14802.003
X-TM-AS-Result: No--15.130100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Phillip: please, so not top-post

Please stop discouraging top posting.  There is no reason to have to 
scroll down through a screen or two of quoted message that you  just 
read the original of, before getting to the new subject matter.

> Jano: please, do not remove Cc people, when replying (i.e. reply to all)
> 
<snip>
> There is a proc/mounts here:
> http://lkml.org/lkml/2006/11/08/322
> 

I didn't ask for /proc/mounts, I asked for the output of the mount 
command with no arguments, which prints the contents of /etc/mtab.  I 
was thinking that /etc/mtab might show the partitions as mounted even 
though they are not, which could be why mount is complaining.


