Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSEVUpZ>; Wed, 22 May 2002 16:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSEVUpY>; Wed, 22 May 2002 16:45:24 -0400
Received: from h-64-105-35-18.SNVACAID.covad.net ([64.105.35.18]:30088 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314280AbSEVUpX>; Wed, 22 May 2002 16:45:23 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 22 May 2002 13:45:15 -0700
Message-Id: <200205222045.NAA02966@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: aic5800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In response to Thomas Huber's query about possible restoration
of the Adaptec AIC-5800 firewire controller driver, I have made a tar
file of my linux-2.5.17 ieee1394 tree available at

	ftp://ftp.yggdrasil.com/private/adam/outgoing/firewire-2.5.17.tar.gz.

	This version of the drivers/ieee1394 subtree includes an
aic5800 driver that I have been updating in the sense that I ensure
that it compiles and seems logical from my very cursory looks at it.
If anyone wants to try it, that would be great.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
