Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGQMvW>; Wed, 17 Jul 2002 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSGQMvV>; Wed, 17 Jul 2002 08:51:21 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:47847 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S313305AbSGQMvU>; Wed, 17 Jul 2002 08:51:20 -0400
Message-ID: <3D356901.A801A78F@delusion.de>
Date: Wed, 17 Jul 2002 14:54:25 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de> <20020717142933.B19385@ucw.cz> <3D356609.11B46A5C@delusion.de> <20020717144410.A19543@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> Can you check with evtest again? Up should be showing as -1, down as 1.

With my patch up is 1 and down is -1 and things scroll the right way.

> If it doesn't, then there is another direction bug elsewhere.

Possibly.

-Udo.
