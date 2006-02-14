Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWBNWBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWBNWBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWBNWBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:01:34 -0500
Received: from smtp.enter.net ([216.193.128.24]:24081 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1422733AbWBNWBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:01:33 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 17:10:37 -0500
User-Agent: KMail/1.8.1
Cc: jengelh@linux01.gwdg.de, seanlkml@sympatico.ca, sam@vilain.net,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner>
In-Reply-To: <43F1F196.nailMWZE1HZK5@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141710.37869.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 10:04, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >> -	SCSI commands are bastardized on ATAPI
> > >
> > >identify the problem - provide a test case or two and I'll get off my
> > > lazy ass and see if I can't figure out what's causing the problem.
> >
> > Maybe we can put a testsuite together that sends all sorts of commands to
> > a cd drive and then see with 1. which Linuxes 2. which models it happens.
>
> You need to ask around for people with problems....
> Debian had some relevent data but removed it the day I was referring to it
> :-(

As the maintainer of the cdrtools package and the author of both libscg and 
cdrecord I find it hard to believe that you do not have a log of these 
somewhere. If Debian had relevant data and removed it, then it is quite 
probable that they fixed the problem already. If that is the case, then all 
it should take to find out is making an enquiry or searching among their 
distribution specific kernel patches.

However, in the spirit of making this discussion bear useful fruit, I will 
take it upon myself to search the Debian archived bugs and see if I can find 
out the relevant data myself.

DRH
