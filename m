Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUHORhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUHORhF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHORhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:37:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8070 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266523AbUHORfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:35:54 -0400
Date: Sun, 15 Aug 2004 19:35:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
In-Reply-To: <20040814210523.GG1387@fs.tum.de>
Message-ID: <Pine.LNX.4.61.0408151932370.12687@scrub.home>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org>
 <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
 <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home>
 <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 14 Aug 2004, Adrian Bunk wrote:

> Unless I misunderstood Roman, FW_LOADER should be no longer selected.

Use it if you really need to, but just don't use it as convenient 
replacement for depends.

bye, Roman
