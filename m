Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWBCNiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWBCNiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBCNiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:38:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:51665 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750772AbWBCNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:38:16 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 14:36:39 +0100
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E35C67.nail5CAF1U9AB@burner>
References: <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
 <20060202214651.GE10352@voodoo>
In-Reply-To: <20060202214651.GE10352@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> > > open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
> > 
> > This is not cdrecord but a bastardized version......

> I know it's not your official version, I was merely pointing out where the
> 'problem' was coming from.

This was only a short reply.... see also my longer reply from today.


J�rg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) J�rg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
