Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSIBUFy>; Mon, 2 Sep 2002 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSIBUFx>; Mon, 2 Sep 2002 16:05:53 -0400
Received: from pD952A8C0.dip.t-dialin.net ([217.82.168.192]:34944 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318435AbSIBUFx>; Mon, 2 Sep 2002 16:05:53 -0400
Date: Mon, 2 Sep 2002 14:10:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Sythos <sythos@neurone.myip.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uhm... not a really bug....
In-Reply-To: <20020902215318.2d165166.sythos@neurone.myip.org>
Message-ID: <Pine.LNX.4.44.0209021409550.3270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Sythos wrote:
> Kernel 2.2.21, all platform.
> 
> make config&make menuconfig missing question about RTL8139, but the
> source is present under network path.

Did you enable CONFIG_PCI, CONFIG_NET_PCI and CONFIG_NET_ETHERNET?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

