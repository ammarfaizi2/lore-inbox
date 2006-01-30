Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWA3P0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWA3P0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWA3P0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:26:44 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:30703 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932320AbWA3P0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:26:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 Jan 2006 16:25:40 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DE2FF4.nail16ZCI3FMV@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
In-Reply-To: <20060129112613.GA29356@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> 2) libscg or cdrecord aborts ATA: scans as soon as one device probe
>    returns EPERM, which lets devices that resmgr made accessible
>    disappear from the list.

looks like your memory does not last long enough......

We did already discuss this before. If you call cdrecord with
apropriatr privileges, it works.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
