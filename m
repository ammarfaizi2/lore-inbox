Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUHTNmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUHTNmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUHTNmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:42:00 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:54991 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267553AbUHTNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:41:43 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 20 Aug 2004 15:40:39 +0200
To: mj@ucw.cz, aia21@cam.ac.uk
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4125FF57.nail8LD5FBNEQ@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <d577e5690408190004368536e9@mail.gmail.com>
 <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz>
 <Pine.LNX.4.60.0408191909570.23309@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0408191909570.23309@hermes-1.csi.cam.ac.uk>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> On Thu, 19 Aug 2004, Martin Mares wrote:
> > (BTW: I am not sure I haven't missed anything in the long cdrecord-related
> > threads on the LKML, but I still haven't seen what is exactly so broken on the
> > cdrecord shipped by SUSE.)
>
> I have been following the discussion quite closely and I concur with you.  
> Noone has actually said what is broken and all I can say is that I use 
> SuSE (9.0 and 9.1 since it came out) and have burnt several CD-Rs and 
> CD-RWs with its version of cdrecord just fine...

Let me repeat: I like to do useful things (e.g. finishing the incremental 
restore code in star) and not constantly be asked to tell you why it is broken.

I did this nuch more than ance in related mailinglist. The fact that you are 
not hit by the bugs is just meanlingless.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
