Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTHANgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTHANgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:36:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5063 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270730AbTHANf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:35:59 -0400
Date: Fri, 1 Aug 2003 15:35:37 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rob Landley <rob@landley.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Messing with Kconfig.
In-Reply-To: <200308010335.07396.rob@landley.net>
Message-ID: <Pine.SOL.4.30.0308011531530.25977-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Aug 2003, Rob Landley wrote:

> 5) Is the indentation level supposed to mean something?  Look at PCI IDE
> chipset support, for example.  Disable it and the indented menu items under
> it disappear, along with a dozen or so menu items underneath it that aren't
> indented.  Am I missing a subtle policy issue here?  (It makes cases like

IDE has been recently fixed, patches are at
http://home.elka.pw.edu.pl/~bzolnier/ide-Kconfig/

Just FYI to not waste time on it. :-)
--
Bartlomiej

