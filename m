Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWBMOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWBMOvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWBMOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:51:12 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:37247 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751278AbWBMOvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:51:12 -0500
Message-ID: <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE>
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Mon, 13 Feb 2006 09:50:38 -0500
From: sean <seanlkml@sympatico.ca>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, sam@vilain.net, peter.read@gmail.com,
       mj@ucw.cz, matthias.andree@gmx.de, lkml@dervishd.net,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060213095038.03247484.seanlkml@sympatico.ca>
In-Reply-To: <43F097AE.nailKUSK1MJ9O@burner>
References: <20060208162828.GA17534@voodoo>
	<43EA1D26.nail40E11SL53@burner>
	<20060208165330.GB17534@voodoo>
	<43EB0DEB.nail52A1LVGUO@burner>
	<Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
	<43EB7210.nailIDH2JUBZE@burner>
	<Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
	<43EB7BBA.nailIFG412CGY@burner>
	<mj+md-20060209.173519.1949.atrey@ucw.cz>
	<43EC71FB.nailISD31LRCB@burner>
	<20060210114930.GC2750@DervishD>
	<43EC88B8.nailISDH1Q8XR@burner>
	<43EFC1FF.7030103@vilain.net>
	<43F097AE.nailKUSK1MJ9O@burner>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.11; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 14:52:09.0515 (UTC) FILETIME=[10C047B0:01C630AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 15:29:02 +0100
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> When looking at the current discussion, it seems to me that most people
> here are still not interested in a fix.

Most people don't see a problem to fix.   Your arguments have been roundly
refuted.   On top of which, cdrecord works on Linux just fine already when
you pass the device node on the command line.   There just isn't much 
motivation to pursue a fix for some theoretical problem that doesn't affect
real users in practice.  Since you are the only one who sees this as a huge
problem you should invest in providing a patch that can be reviewed for 
inclusion.

Sean
