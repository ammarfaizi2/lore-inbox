Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946147AbWBDLIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946147AbWBDLIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946159AbWBDLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:08:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2231 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1946147AbWBDLIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:08:52 -0500
Date: Sat, 4 Feb 2006 12:08:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: psusi@cfl.rr.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E3ABBA.nail6AV41818M@burner>
Message-ID: <Pine.LNX.4.61.0602041208150.30014@yvahk01.tjqt.qr>
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mai <43E374CF.nail5CAMKAKEV@burner>
 <43E38084.9040200@cfl.rr.com> <43E38B51.nail5CAZ1GYRE@burner>
 <Pine.LNX.4.61.0602032005550.19459@yvahk01.tjqt.qr> <43E3ABBA.nail6AV41818M@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >It does not prevent you from creatig a coaster in case you connect e.g.
>> >two ATAPI writers to the same ATA cable.
>> >
>> Apart from transfer speed issues and potential buffer underruns coming 
>> along with that, is there anything technically impossible with writing to 
>> two ATAPI drives at the same time?
>
>It depends on what type of drive you use.
>
>If you chose a drive that blocks the ATA cable while processing a 
>START/STOP/UNIT, you are out of luck.
>
That may be what I experienced with that aopen writer.



Jan Engelhardt
-- 
