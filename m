Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWBCS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWBCS6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWBCS6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:58:41 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43668 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1422654AbWBCS6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:58:40 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 19:57:35 +0100
To: schilling@fokus.fraunhofer.de, khc@pm.waw.pl
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E3A79F.nail6AV1Z7299@burner>
References: <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
 <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
 <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
 <m3hd7ge3j2.fsf@defiant.localdomain>
In-Reply-To: <m3hd7ge3j2.fsf@defiant.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "Jim Crilly" <jim@why.dont.jablowme.net> writes:
>
> > A bug in HAL is not a bug in Linux. If the HAL people need to make some
> > changes to their daemon to make it play nice with cdrecord and the like
> > that's fine, but telling people here makes no sense.
>
> Does that mean that hald doesn't actually play nice with cdrecord?

I cannot speak from own experiences on Linux here, but this is what I see:

-	If you check Linux distributions for related bug reports,
	you find many problems with hald.

-	If you try to find similar bug reports for Solaris vold, there is
	no report I am aware of.

Trying to rate this would make me asume that hald could be changed to play
better with cdrecord.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
