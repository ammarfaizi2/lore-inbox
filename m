Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946163AbWBDLPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946163AbWBDLPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946166AbWBDLPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:15:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35732 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1946163AbWBDLPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:15:32 -0500
Date: Sat, 4 Feb 2006 12:15:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig: no colors in 2.6.12-rc2 ?
In-Reply-To: <20060204080613.GA8655@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0602041215130.30014@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0602031957070.4864@dyndns.pervalidus.net>
 <20060203222843.GA11973@mars.ravnborg.org> <964857280602031447l57df7c1epced4a6f14979ce30@mail.gmail.com>
 <20060204080613.GA8655@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Try to rename ncursesw to ncurses in
>> > scripts/kconfig/lxdialog/check-dialog.sh
>> > to test if ncursesw is the culprint.
>> 
>> Yes, that worked. Is it a bug in ncursesw ? I'm using a recent one.
>
>Yes, I assume so. Eithet that or something local on your setup.
>I have reports from others where use of ncursesw gives them nice looking
>ASCII symbols in text mode and colours.
>I do not have ncursesw myself so no possibility to test.
>
WFM.



Jan Engelhardt
-- 
