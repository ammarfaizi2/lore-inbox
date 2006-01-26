Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWAZM3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWAZM3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAZM3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:29:34 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:8324 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932310AbWAZM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:29:33 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 13:27:59 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8C04F.nailE1C2X9KNC@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
In-Reply-To: <20060125230850.GA2137@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Joerg Schilling schrieb am 2006-01-25:
>
> > > You are perfectly free to adjust your compatibility layer accordingly.
> > 
> > The Linux Kernel fols unfortunately artificially hides information for the 
> > /dev/hd* interface making exactly this compatibility impossible.
>
> What information is actually missing? You keep talking about phantoms,
> without naming them. Again: device enumeration doesn't count, libscg
> already does that.

I am not talking about phantoms, I am always requestung the same things.
It only seems that people here ignore these issues.

The only integrative (and this useful for libscg) interface on Linux is /dev/sg*

/dev/hd* may look nice if you only look skin-deep

How do you e.g. like send SCSI commands to ATAPI tape drives on Linux?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
