Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWBBLST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBBLST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWBBLST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:18:19 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:39066 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750759AbWBBLSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:18:18 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Feb 2006 12:17:09 +0100
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E1EA35.nail4R02QCGIW@burner>
References: <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
In-Reply-To: <20060202062840.GI5501@mail>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly <jim@why.dont.jablowme.net> wrote:

> Every other method to access those devices uses the device name, i.e.
> mount, fsck, etc, so why should cdrecord be different?

inadequateness on Linux did force libscg to go this way.

The current method used by libscg is well established since 10 years.

Now Linux likes to confuse people by trying to enforce a completely 
incompatible access method.

Note that I need to avoid unneeded efforts and for this reason, I need to wait
5 years until is is forseable that a recent incompatible change in Linux will
survive long enough to spent time on it.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
