Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWBJMlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWBJMlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBJMlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:41:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2270 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751240AbWBJMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:41:36 -0500
Date: Fri, 10 Feb 2006 13:41:35 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, peter.read@gmail.com, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060210.123726.23341.atrey@ucw.cz>
References: <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC887B.nailISDGC9CP5@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, this is a deficit of the Linux kernel - not libscg.

This is exactly what I have written -- extra effort is needed to get
a stable numbering (which Solaris does), but you can use a very similar
extra care to get stable names (which Linux with udev does).

So I really se no advantage in preferring the numeric addresses over
device names, while device names have the obvious advantage of working
for all devices, not only SCSI.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Light-year? One-third less calories than a regular year.
