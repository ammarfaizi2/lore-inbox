Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318707AbSG0HcA>; Sat, 27 Jul 2002 03:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSG0HcA>; Sat, 27 Jul 2002 03:32:00 -0400
Received: from adsl-66-136-196-103.dsl.austtx.swbell.net ([66.136.196.103]:64641
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S318707AbSG0Hb7>; Sat, 27 Jul 2002 03:31:59 -0400
Subject: Re: 2.4.19-rc3-aa1 and FB Console
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1027755034.2571.34.camel@UberGeek.digitalroadkill.net>
References: <1027630426.30406.1.camel@UberGeek>
	 <1027755034.2571.34.camel@UberGeek.digitalroadkill.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1027755214.2571.39.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 Jul 2002 02:33:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Woops. I figured it out. I'm just dumb. I have to select experimental to
see the selections I'm looking for. Sorry for the bandwidth. I didn't
notice this being the case in RC1 and RC2. 

On Sat, 2002-07-27 at 02:30, Austin Gonyou wrote:
> Let me clarify a bit further. When creating the kernel tree in the
> following manner:
> 
> 1. untar 2.4.18
> 2. apply 2.4.19-rc3 patch
> 3. apply 2.4.19-rc3-aa(1|2) patch
> 4. make menuconfig | xconfig
> 
> I only have the following available under "Console Drivers":
>   <> VGA text console
>   <> Video mode selection support
> 
> It used to be when selecting "Video mode selection support" that many
> more items were then available, like the support for resolutions, font
> types, etc. I don't see that in rc3, but did in rc2. 
> 
> Please advise, I really wanna try rc3, but can't get past this one thing
> TIA.
> 

-- 
Austin Gonyou <austin@digitalroadkill.net>
