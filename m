Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbTABEEZ>; Wed, 1 Jan 2003 23:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbTABEEZ>; Wed, 1 Jan 2003 23:04:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:43497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265475AbTABEEY>;
	Wed, 1 Jan 2003 23:04:24 -0500
Date: Wed, 1 Jan 2003 20:10:07 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <Pine.LNX.4.44.0301012129530.2431-100000@dell>
Message-ID: <Pine.LNX.4.33L2.0301012009220.21318-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Robert P. J. Day wrote:

| On Wed, 1 Jan 2003, Randy.Dunlap wrote:
|
| > Greg Banks has (had) a real nice program for checking
| > dependency ordering using Config.in files.  It would be
| > very nice if it now worked with Kconfig files.  :)
| > It could be used for this type of config reordering to
| > verify that things weren't screwed up.  I used it when
| > I moved Network Devices to just under/after Network Options
| > to show that no dependency ordering was mangled by that patch.
|
| so are you saying that there should be no backward dependencies
| in the list of menus?  i remember just that in the 2.4 screens,
| when you could select hardware sensors and then, on a
| subsequent screen, deselect I2C which would, as a result,
| deselect sensors on that previous screen.
|
| you're saying that, the way these menus are ordered, this
| type of thing should be avoided?

Tomas Szepe just corrected me on this...no longer an issue.

Thanks,
-- 
~Randy

