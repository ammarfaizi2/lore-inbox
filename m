Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTGNNsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbTGNNsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:48:03 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:8930 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270620AbTGNNpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:45:16 -0400
Date: Mon, 14 Jul 2003 14:59:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Anders Gustafsson - xbox patch monkey <andersg@0x63.nu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714135948.GA27930@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Anders Gustafsson - xbox patch monkey <andersg@0x63.nu>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 02:49:33PM +0200, Anders Gustafsson - xbox patch monkey wrote:
 > A wise man recently said:
 > 
 > ''That pretty much cuts the list of "needs to be supported" down to x86,
 >   ia64, x86-64 and possibly sparc/alpha.''
 > 
 > Some parts of x86 are still not supported, namely the bastardized PC called
 > Xbox. The patch below fixes that. Rediffed to latest bk.
 > 
 > Please apply. Sn?lla.

First you should read (and preferably act upon) the comments
sent the last time you posted this.

Notably the gcc 'workaround' and the HZ ifdef maze.

		Dave

