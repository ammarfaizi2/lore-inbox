Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284823AbRL2NcQ>; Sat, 29 Dec 2001 08:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287191AbRL2NcG>; Sat, 29 Dec 2001 08:32:06 -0500
Received: from maild.telia.com ([194.22.190.101]:64249 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S284823AbRL2Nb4>;
	Sat, 29 Dec 2001 08:31:56 -0500
Date: Sat, 29 Dec 2001 14:36:42 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sound stops while playing DVD with via82cxxx_audio driver
Message-ID: <20011229133642.GA679@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011228192700.GA7346@telia.com> <E16K6Q9-0002Db-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E16K6Q9-0002Db-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Random guess of the week. Disable ACPI support and turn off APM in the BIOS
> then repeat the test. If that stops it then it sounds like some kind of
> power management is turning off the codec.
> 
> Let us know what it shows 

Sadly that didn't help. ACPI was not enabled, but APM was. I disabled
Power Management altogether in the kernel, and set all power management
features in the bios to disabled, but still the same thing happens. I'm
starting to think that someting has gone wrong with the DVD-drive,
especially since the same thing happens in that other OS.

Thanks for the tip though Alan,
-- 

André Dahlqvist <andre.dahlqvist@telia.com>

