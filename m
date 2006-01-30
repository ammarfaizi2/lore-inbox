Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWA3RiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWA3RiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWA3RiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:38:24 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:52642 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964838AbWA3RiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:38:24 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 18:37:07 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DE4EC3.nail2D51I6BPD@burner>
References: <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
 <43DD2A8A.nailGVQ115GOP@burner>
 <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com>
 <43DE3A99.nail16ZK1MAWN@burner>
 <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com>
 <43DE405D.nail2AM2BPF20@burner>
 <20060130170813.GG19173@merlin.emma.line.org>
 <43DE495A.nail2BR211K0O@burner>
 <20060130173028.GA5452@merlin.emma.line.org>
In-Reply-To: <20060130173028.GA5452@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Joerg Schilling schrieb am 2006-01-30:
>
> > Let me ask again:
> > 
> > 	Is there a way to get (or construct) a closed view on the namespace 
> > 	for all SCSI devices?
>
> Of course there is, /dev/sg*.
>
> But that is not what you're _actually_ asking - you appear to desire a
> unified namespace for SCSI + ATAPI + whatever, and the answer to that
> was /dev/*.

I am only asking for a unique name space for all devices that talk SCSI.

And please: read the SCSI Standard on t10.org to learn that ATA is just one
of many possible SCSI transports.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
