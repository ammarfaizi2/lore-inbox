Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbSJAQYu>; Tue, 1 Oct 2002 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSJAQYu>; Tue, 1 Oct 2002 12:24:50 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:6452 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262144AbSJAQYc>;
	Tue, 1 Oct 2002 12:24:32 -0400
Date: Tue, 1 Oct 2002 18:29:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021001162955.GA19132@win.tue.nl>
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <20021001155428.GA19122@win.tue.nl> <20021001175537.A13220@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001175537.A13220@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 05:55:37PM +0200, Vojtech Pavlik wrote:

> Ok. Where is the most recent version of [gs]etkeycodes?

In kbd-1.06. It is from May 2001, and I have been planning kbd-1.07
for a while but there were no urgent changes, just more fonts and
keymaps and the like. When you are done it is a good occasion for
kbd-1.07.

Andries

Begin3
Title:          Keyboard and console utilities for Linux
Version:        1.06
Entered-date:   2001-05-19
Description:    loadkeys dumpkeys setfont chvt openvt kbd.FAQ A20 etc.
Keywords:       keyboard mapping console font unicode
Author:         several
Maintained-by:  Andries E. Brouwer (aeb@cwi.nl)
Primary-site:   ftp://ftp.win.tue.nl/pub/linux-local/utils/kbd
                773433 kbd-1.06.tar.gz
Alternate-site: ftp://ftp.*.kernel.org/pub/linux/utils/kbd
Alternate-site: ftp://sunsite.unc.edu/pub/Linux/system/keyboards
Alternate site: ftp://ftp.cwi.nl/pub/aeb/kbd
Copying-policy: GPL
End
