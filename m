Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBIKTZ>; Fri, 9 Feb 2001 05:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129621AbRBIKTP>; Fri, 9 Feb 2001 05:19:15 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:44812 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129396AbRBIKTG>;
	Fri, 9 Feb 2001 05:19:06 -0500
Message-ID: <3A83C4A1.5090903@megapathdsl.net>
Date: Fri, 09 Feb 2001 02:21:21 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; m18) Gecko/20010208
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> christophe barbe wrote:
> 
> 
>> Moreover there is no need to be ignorant. With LPP, messages are displayed during the boot process and if something goes wrong an little picture inform you. And you can switch to the classic console when you want (by a simple CTRL-ALT-F2).
> 
> 
> Interesting.  Stuff that makes linux look good is good, but please
> make it optional.  (Perhaps a kernel parameter, boot=pretty)
> Simple users can have their pretty boot, but some of us think
> the text console is cool too.  Much like having one of those
> cars with a plexiglass hood so anybody may admire the
> fancy engine.

Right.  Add the option.  Default to "spew mode",
but make it easy for distributions to show people
a non-threatening boot process.  

Anyone who thinks that there aren't lots of people 
who simply freeze in terror at the thought of having
to understand and tweak their computers obviously
needs to spend more time socializing with non-gearheads.
For example, everytime I have tried to explain anything
to my mother-in-law about her computer, I might as well
be speaking Mongolian.  She gets confused if someone 
rearranges her desktop icons.  

Since, as Christophe mentions, the boot messages would
still be accessible via CTRL-ALT-F2, I don't see what 
the problem is with at least making this an option.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
