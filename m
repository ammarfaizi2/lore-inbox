Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSAXIlZ>; Thu, 24 Jan 2002 03:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbSAXIlP>; Thu, 24 Jan 2002 03:41:15 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:4615 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S284933AbSAXIk4>; Thu, 24 Jan 2002 03:40:56 -0500
From: Norbert Preining <preining@logic.at>
Date: Thu, 24 Jan 2002 09:40:48 +0100
To: linux-kernel@vger.kernel.org
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: amd athlon cooling on kt266/266a chipset
Message-ID: <20020124094048.A17305@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel!

You wrote:
> 2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
>    in the kernel config

Why is it necessary to activate acpi which makes apm not working,
and therefor poweroff etc. acpi is long from working/stable and
the support for various actions too are missing.

>From the patch I do not see why it is specific to acpi?

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
KNOPTOFT (n.)

The mysterious fluff placed in your pockets by dry-cleaning firms.

			--- Douglas Adams, The Meaning of Liff 
