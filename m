Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVFAPpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVFAPpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFAPnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:43:22 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31974 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261433AbVFAPm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:42:56 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 17:41:39 +0200
To: lsorense@csclub.uwaterloo.ca, kraxel@suse.de
Cc: toon@hout.vanvergehaald.nl, schilling@fokus.fraunhofer.de,
       mrmacman_g4@mac.com, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DD733.nail7BF915O9X@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
 <20050531190556.GK23621@csclub.uwaterloo.ca>
In-Reply-To: <20050531190556.GK23621@csclub.uwaterloo.ca>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:

> > Addressing IDE devices (try to get a real SCSI burner these days)
> > using scsi host+target+lun is sort-of silly IMHO ...
>
> Well I remember the first time I saw devfs running, I thought "Wow
> finally I have a way to find the disc that is scsi id 3 on controller 0
> even if I add a device at id 2 after setting up the system", something
> most unix systems have always had, but linux made hard (you had to
> somehow figure out which id mapped to which /dev/sd* entry, which from a
> users perspective wasn't trivial, and of course keeping your fstab in
> sync with the mapping was a pain).

What you explain is exactly the reason, why libscg maps the /dev/ names
to something stable.

Then some people claimed that there was a new way in Linux but I could
not find a machine running this stuff.....

When I checked again, this still had not become "standard" on Linux
but I got the impression that somebody was developing a new system.
So I gave up.

If someone will develop a useful system that eventually appears as
a standard on all Linux systems it may make sende to add support into
libscg.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
