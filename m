Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWAZOQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWAZOQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWAZOQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:16:16 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:11252 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932330AbWAZOQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:16:16 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 15:14:58 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de, axboe@suse.de,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D962.nailE2XE6V7X6@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de>
 <5a2cf1f60601251401h2cced00ele307636e748b9a7b@mail.gmail.com>
 <43D8BCFE.nailE1C116RR9@burner>
 <mj+md-20060126.122723.14374.atrey@ucw.cz>
In-Reply-To: <mj+md-20060126.122723.14374.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> > On Linux-2.4, cdrecord's abstraction is the only way to hide the security 
> > relevent non-stable /dev/sg* <-> device relation.
>
> OK. So welcome to year 2006. And to Linux 2.6.

When will Linux arrive in 2006 and support ATAPI and SCSI in general, not just 
ATAPI for hard disk drives and CD-ROMS?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
