Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271373AbTG2KQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTG2KQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:16:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22020 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271373AbTG2KQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:16:42 -0400
Date: Tue, 29 Jul 2003 12:16:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH 1/6] [DVB] Kconfig and Makefile updates
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01BF88A1@mesadm.epl.prov-liege.be>
Message-ID: <Pine.LNX.4.44.0307291215100.714-100000@serv>
References: <D9B4591FDBACD411B01E00508BB33C1B01BF88A1@mesadm.epl.prov-liege.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Jul 2003, Frederick, Fabian wrote:

> 	Does \t a standard for menu entries definition ?

No.

> I keep seeing
> multiple spaces in some places which can be troublesome to kernelServer for
> instance.

You really shouldn't parse the Kconfig files yourself, use the library for 
this.

bye, Roman

