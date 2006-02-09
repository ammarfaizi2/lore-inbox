Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWBIQa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWBIQa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBIQa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:30:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37608 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932349AbWBIQa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:30:28 -0500
Date: Thu, 9 Feb 2006 17:30:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: jim@why.dont.jablowme.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43EB0DEB.nail52A1LVGUO@burner>
Message-ID: <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please explain me:
>
>-	how to use /dev/hd* in order to scan an image from a scanner
>-	how to use /dev/hd* in order to talk to a CPU device
>-	how to use /dev/hd* in order to talk to a tape device
>-	how to use /dev/hd* in order to talk to a printer
>-	how to use /dev/hd* in order to talk to a jukebox
>-	how to use /dev/hd* in order to talk to a graphical device
>
With /dev/sg, this was possible?


Jan Engelhardt
-- 
