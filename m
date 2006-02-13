Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWBMPON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWBMPON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWBMPON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:14:13 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:58024 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932431AbWBMPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:14:11 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:12:51 +0100
To: trudheim@gmail.com, schilling@fokus.fraunhofer.de
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, davidsen@tmr.com,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A1F3.nailKUSV1V88J@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
 <43F0776F.nailKUS94FU3M@burner>
 <515e525f0602130446s1091f09ande10910f65a0f5f0@mail.gmail.com>
In-Reply-To: <515e525f0602130446s1091f09ande10910f65a0f5f0@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson <trudheim@gmail.com> wrote:

> On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> [snip]
> > -       Older CD-writers identified as WORM although a CD-R is not a WORM.
>
> Nitpicking I know, but technically, CD-R is WORM in the case of single
> session write. And as long as the writer works, who cares if it is
> labled WORM, CD-R or Earthworm..

If you did know what a worm is, you would know that you are not correct:

A WORM allows you to randomly write any sector once.

A CD-R does not allows you to do this.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
