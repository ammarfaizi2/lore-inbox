Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWBTQmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWBTQmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWBTQmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:42:31 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40112 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161027AbWBTQma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:42:30 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 20 Feb 2006 17:41:02 +0100
To: matthias.andree@gmx.de, dhazelton@enter.net
Cc: schilling@fokus.fraunhofer.de, nix@esperi.org.uk, mj@ucw.cz,
       linux-kernel@vger.kernel.org, davidsen@tmr.com, chris@gnome-de.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F9F11E.nail5BM21M01Q@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <200602182010.02468.dhazelton@enter.net>
 <20060219092059.GA21626@merlin.emma.line.org>
 <200602192053.25767.dhazelton@enter.net>
In-Reply-To: <200602192053.25767.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > Part of the problem is Jörg's expecting a solution the day before
> > yesterday.
>
> Well, from some comments he made in private mails he seems to think he was 
> promised (by Linus, no less) that the DMA problems in ide-scsi were going to 
> be fixed. Instead the module was deprecated and SG_IO was introduced - this 
> seems to be one of the things he's been angry about.

Even you have become a victim of the trolls :-(

SG_IO was used in ide-scsi a long time before it was needlessly introduced 
on top of /dev/hd*

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
