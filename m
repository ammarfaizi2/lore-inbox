Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWBCNr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWBCNr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBCNr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:47:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35275 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750785AbWBCNr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:47:27 -0500
Date: Fri, 3 Feb 2006 14:47:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602031446530.7991@yvahk01.tjqt.qr>
References: <43DDFBFF.nail16Z3N3C0M@burner>  <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
  <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> 
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> 
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> 
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>  <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Giving up while scanning is a problem for other reasons.
>Let me introduce you to SE Linux. One can have RAWIO
>capability, RT capability, mlock() capability, and still not
>have the right to access all devices. You might not even
>be able to get stat() to succeed, but you could burn a CD
>if you use the correct device file.
>
Unfortunately, setting up SELinux is currently not easy.

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
