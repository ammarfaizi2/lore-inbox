Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSLNXJY>; Sat, 14 Dec 2002 18:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSLNXJY>; Sat, 14 Dec 2002 18:09:24 -0500
Received: from mail.michigannet.com ([208.49.116.30]:53004 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S266042AbSLNXJX>; Sat, 14 Dec 2002 18:09:23 -0500
Date: Sat, 14 Dec 2002 18:17:08 -0500
From: Paul <set@pobox.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com,
       linux-lvm@sistina.com
Subject: Re: New device-mapper patchset for 2.5.51
Message-ID: <20021214231708.GB1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	Linux Mailing List <linux-kernel@vger.kernel.org>,
	lvm-devel@sistina.com, linux-lvm@sistina.com
References: <20021213115014.GA15675@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213115014.GA15675@reti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <joe@fib011235813.fsnet.co.uk>, on Fri Dec 13, 2002 [11:50:14 AM] said:
> If anyone was experiencing problems with dm could they please try this
> patchset and give me feedback.
> 
> Thanks,
> 
> - Joe
> 
> 
> 
> http://people.sistina.com/~thornber/patches/2.5-stable/2.5.51/2.5.51-dm-3.tar.bz2
> 

	Hi;

	I havent tried 2.5.51 vanila, but 2.5.51 with dm-3 patch
is working well so far for me on LVM system. (All other 2.5
kernels tried would hit a BUG()-- already reported.)
	If anyone wants me to recommend some sort of stress test
let me know; Ive simpley constructed and populated several
fileystems, md5sum'ed all the files, bzip2'd them, rm'd them,
etc. Then several hours of looping kernel compiles.
	Thanks for the work of the contributers.

Paul
set@pobox.com
