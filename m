Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSGFNuY>; Sat, 6 Jul 2002 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGFNuX>; Sat, 6 Jul 2002 09:50:23 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:23527 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315517AbSGFNuW>; Sat, 6 Jul 2002 09:50:22 -0400
Date: Sat, 6 Jul 2002 07:42:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Bill Davidsen <davidsen@tmr.com>
cc: Andries Brouwer <aebr@win.tue.nl>, Adrian Bunk <bunk@fs.tum.de>,
       Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk IO statistics still buggy
In-Reply-To: <20020706074824.GA24771@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0207060740020.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 06, 2002 at 12:15:47AM -0400, Bill Davidsen wrote:
> > Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
> > remove these statistics completely from /proc/partitions...
> 
> Is this the new Linux way of life? Removing modules is hard, GET RID OF
> THE FEATURE! Stats in /proc/partitions are not always correct, GET RID OF
> THE FEATURE!

You misunderstood. It was nothing incorrect about the stats in 
/proc/partitions, it was just moved because it just didn't belong into 
/proc/partitions.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

