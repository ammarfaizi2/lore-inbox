Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317885AbSGVWIx>; Mon, 22 Jul 2002 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317886AbSGVWIx>; Mon, 22 Jul 2002 18:08:53 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:16138 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S317885AbSGVWIw>; Mon, 22 Jul 2002 18:08:52 -0400
Date: Mon, 22 Jul 2002 15:11:13 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Ernst Lehmann <lehmann@acheron.franken.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with AMD 768 IDE support
In-Reply-To: <1027364446.26894.2.camel@hadley>
Message-ID: <Pine.LNX.4.44.0207221504380.2225-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2002, Ernst Lehmann wrote:

> Hi,
> 
> I have here a Dual-Athlon Box, with a AMD760MPX Chipset and AMD768 IDE.
> 
> In the base 2.4.18 kernel there seems to be no support for the
> IDE-Chipset
> 
> So I tried 2.4.19-rc3-ac1 and I got more APIC errors, than I can count
> :))
> 
> So my question.
> 
> Does anybody know where to find a patch for the IDE-Support to the plain
> 2.4.18 kernel,
> 
> or which version of the 2.4.19-rc<x>-ac<x> is stable enough at the
> moment to run such a box.
> 
> TIA for any help...

I've got two of these machines running with 2.4.19-rc2 at the moment; no 
APIC errors you speak of. Before, they were running 2.4.19-pre9-ac2, also 
with no APIC errors. Perhaps you have a hardware problem?




 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

