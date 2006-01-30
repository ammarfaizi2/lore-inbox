Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWA3QNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWA3QNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWA3QNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:13:21 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43140 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932357AbWA3QNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:13:21 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 17:12:21 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DE3AE5.nail16ZL1UH7X@burner>
References: <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr>
 <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org>
In-Reply-To: <20060130120408.GA8436@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > Cdrecord is a program that needs to be able to send any SCSI command as 
> > it needs to be able to add new vendor unique commands for new drive/feature
> > support.
>
> Right, but evidently it does not need the kernel to invent numbering.
> dev=/dev/hdc works today.

Maybe, I will need to enforce to use official libscg device names in future....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
