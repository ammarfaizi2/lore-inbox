Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWBBUjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBBUjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWBBUjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:39:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59042 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932223AbWBBUjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:39:09 -0500
Date: Thu, 2 Feb 2006 21:39:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <43D8C04F.nailE1C2X9KNC@burner>
  <43DDFBFF.nail16Z3N3C0M@burner>  <1138642683.7404.31.camel@juerg-pd.bitron.ch>
  <43DF3C3A.nail2RF112LAB@burner>  <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
  <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> 
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'm seeing even worse behavior. Since /dev/hda is a disk with mounted
>filesystems, my kernel refuses access even for root. Thus, even root
>is unable to scan the /dev/hd* devices!
>
What sort of kernel patch do you have turned on? I'd be scared if I could 
not even do a (read-only!) hexdump of my drive while mounted.


Jan Engelhardt
-- 
