Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135273AbRAYAoX>; Wed, 24 Jan 2001 19:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbRAYAoN>; Wed, 24 Jan 2001 19:44:13 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57608
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129444AbRAYAnz>; Wed, 24 Jan 2001 19:43:55 -0500
Date: Wed, 24 Jan 2001 16:43:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: mirabilos <eccesys@topmail.de>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: when is overriding idebus safe?
In-Reply-To: <015b01c08656$1b0d4da0$0100a8c0@homeip.net>
Message-ID: <Pine.LNX.4.10.10101241643140.15294-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because you do not have IDE_PCI enabled.

On Wed, 24 Jan 2001, mirabilos wrote:

> I get:
> 
> ide: Assuming 40 MHz system bus speed for PIO modes; override with idebus=xx
> 
> ??? you all say it's 33 hardcoded...
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12+custom(^=href;C-style-comments)
> GO/S dx@ s--: a--->---- C++ UL++++ P--- L++$(-^lang) E----/joe W+(++)
> N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv!----
> b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM, GW-BASIC, C */
> ------END GEEK CODE BLOCK------
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
