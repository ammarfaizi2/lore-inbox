Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266178AbUALMZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUALMZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:25:05 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:65028 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266178AbUALMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:24:59 -0500
Date: Mon, 12 Jan 2004 13:25:38 +0100
From: DervishD <raul@pleyades.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP or UP???
Message-ID: <20040112122538.GD18408@DervishD>
References: <200401121211.i0CCBg5u006677@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401121211.i0CCBg5u006677@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mikael :)

 * Mikael Pettersson <mikpe@csd.uu.se> dixit:
> >kernel: found SMP MP-table at 000fb210
> >    What, SMP table?
> You have an anti-problem. The chipset includes an I/O-APIC
> (good) and your mobo manufacturer was decent enough to include
> the appropriate BIOS MP tables to describe it to the OS.

    Oh, nice. I thought that the mobo was a simple reisuing of a SMP
mobo from Gigabyte with one socket removed O:)

> Other manufacturers skip the MP table, forcing you to enable
> ACPI and pray it actually works. 

    Excuse my ignorance but: why a UP system needs the MP table? Why
the I/O-APIC needs anything related with multiprocessor in an UP
system?. I lost my way on hardware back in the 486, I think...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
