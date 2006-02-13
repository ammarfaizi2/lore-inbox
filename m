Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWBMQaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWBMQaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWBMQaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:30:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62164 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932097AbWBMQaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:30:05 -0500
Date: Mon, 13 Feb 2006 17:29:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F09E67.nailKUSQCAD6I@burner>
Message-ID: <Pine.LNX.4.61.0602131728530.24297@yvahk01.tjqt.qr>
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner> <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner> <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner> <mj+md-20060213.104344.18941.atrey@ucw.cz>
 <43F09E67.nailKUSQCAD6I@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Solaris, adding a new controler always asigns this new controler a new
>higher ID (except for the case when the sysadmin explicitly requests different 
>behavior).

What if the OS runs out of next-higher IDs?

