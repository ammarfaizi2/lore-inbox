Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSGQKUn>; Wed, 17 Jul 2002 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSGQKUm>; Wed, 17 Jul 2002 06:20:42 -0400
Received: from smtp.rhein-zeitung.DE ([212.7.160.14]:9417 "EHLO
	smtp.rhein-zeitung.DE") by vger.kernel.org with ESMTP
	id <S318240AbSGQKUl>; Wed, 17 Jul 2002 06:20:41 -0400
Date: Wed, 17 Jul 2002 12:23:27 +0200
From: Oliver Graf <ograf@rz-online.net>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717102327.GA31686@rz-online.net>
References: <3D35435F.E5CFA5E2@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D35435F.E5CFA5E2@delusion.de>
User-Agent: Mutt/1.3.27i
X-PGP-Key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x0B17417A
X-RIPE-Key-Cert: PGPKEY-0B17417A
Organization: KEVAG Telekom GmbH / RZ-Online GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 12:13:51PM +0200, Udo A. Steinberg wrote:
> I'm running 2.5.26 with an ordinary PS/2 keyboard and a 5 button PS/2 mouse.
> When using the old psaux driver the mouse works fine.
> With input core support, however, the scroll wheel doesn't work properly.
> In my XF86Config I'm using IMPS/2 protocol and ZAxisMapping 4 5.
> Scrolling up causes the window to scroll down. Scrolling down doesn't do
> anything. When changing the protocol to ExplorerPS2 things are not much
> better. You can't drag windows over the screen.

I think this is no kernel problem. You have 7 buttons (5 + 2 wheel).

Try this: http://www.deadman.org/X/xbuttons.html or google for
intellimouse and linux.

Regards,
  Oliver.

