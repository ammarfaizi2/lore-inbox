Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSGQNFU>; Wed, 17 Jul 2002 09:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGQNFT>; Wed, 17 Jul 2002 09:05:19 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:60391 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S313421AbSGQNFS>; Wed, 17 Jul 2002 09:05:18 -0400
Message-ID: <3D356C48.3E9743C9@delusion.de>
Date: Wed, 17 Jul 2002 15:08:24 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de> <20020717142933.B19385@ucw.cz> <3D356609.11B46A5C@delusion.de> <20020717144410.A19543@ucw.cz> <3D356901.A801A78F@delusion.de> <20020717150043.A19609@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> What protocol are you using in X?

ImPS/2

> Does this happen with both ExplorerPS/2 and ImPS/2?

Both ImPS/2 and ExplorerPS/2 behave the same way when configured with
5 buttons and ZAxisMapping 4 5.

When using ExplorerPS/2 with 7 buttons and ZAxisMapping 6 7, then
scrolling doesn't work at all, however evtest displays all button
and scroll events correctly (with scroll directions reversed).

-Udo.
