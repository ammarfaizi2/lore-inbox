Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWBBVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBBVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBBVV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:21:29 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:39167 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932249AbWBBVV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:21:28 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Feb 2006 22:20:18 +0100
To: jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E27792.nail54V1B1B3Z@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo>
In-Reply-To: <20060202210949.GD10352@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> I see the same thing with, the only external kernel patch I have
> applied is Suspend2. The ATA scanbus code tries to 
> open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since

This is not cdrecord but a bastardized version......

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
