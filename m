Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTCTJ2K>; Thu, 20 Mar 2003 04:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTCTJ2K>; Thu, 20 Mar 2003 04:28:10 -0500
Received: from [196.41.29.142] ([196.41.29.142]:37879 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261335AbTCTJ2K>; Thu, 20 Mar 2003 04:28:10 -0500
Subject: Re: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
From: Martin Schlemmer <azarah@gentoo.org>
To: Dominik Brodowski <linux@brodo.de>
Cc: alan@lxorguk.ukuu.org.uk, KML <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
In-Reply-To: <20030320084148.GA2414@brodo.de>
References: <20030319211837.GA23651@brodo.de>
	 <1048146514.12350.43.camel@workshop.saharact.lan>
	 <20030320084148.GA2414@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1048152980.4384.49.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 20 Mar 2003 11:36:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 10:41, Dominik Brodowski wrote:

> > The ASUS P4T533-C J(850E Chipset) does that as well .... think you might
> > tweak the patch for this board ?  I can test if you can ....
> 
> Sure: please send me the output of "pcitweak -l" or "lspci -vv".
> 
> 	Dominik

Right, will do tonight when I get home.


-- 
Martin Schlemmer


