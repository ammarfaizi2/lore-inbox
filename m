Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTIFNgp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 09:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbTIFNgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 09:36:45 -0400
Received: from lucidpixels.com ([66.45.37.187]:40878 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261238AbTIFNgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 09:36:44 -0400
Date: Sat, 6 Sep 2003 09:36:42 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: CONFIG_AGP_INTEL Question.
Message-ID: <Pine.LNX.4.56.0309060935320.10980@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering when/how often do updates take place to this driver?
I have an Intel i875 chipset and was wondering when it would be possible
to use AGPGART/etc (to use GLX/3D stuff).


CONFIG_AGP_INTEL:

This option gives you AGP support for the GLX component of the
XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860
chipsets.

You should say Y here if you use XFree86 3.3.6 or 4.x and want to
use GLX or DRI.  If unsure, say N.
