Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUDOSz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUDOSz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:55:26 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:58269 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263172AbUDOSyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:54:19 -0400
Date: Thu, 15 Apr 2004 20:54:14 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, Grzegorz Kulewski <kangur@polcom.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040415185414.GF18971@charite.de>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	"R. J. Wysocki" <rjwysocki@sisk.pl>,
	Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <200404071321.01520.rjwysocki@sisk.pl> <20040407113004.GA2574@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040407113004.GA2574@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vojtech Pavlik <vojtech@suse.cz>:

> > Look, I've been using different variants of the 2.6.x kernels on this very 
> > machine/distro since early 2.6.0-test and I hadn't seen _anything_ like this 
> > before 2.6.5-rc2 (then I saw something like this first).  I _really_ don't 
> > think it's a distribution-related issue.
> 
> Maybe you could enable debugging in i8042.c, and look at the log around
> the unexpected reconnect of the keyboard.

How? Enlighten us...

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
