Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287179AbRL2LCM>; Sat, 29 Dec 2001 06:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287178AbRL2LCC>; Sat, 29 Dec 2001 06:02:02 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:15367 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S287179AbRL2LBt>; Sat, 29 Dec 2001 06:01:49 -0500
Date: Sat, 29 Dec 2001 13:01:47 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011229130147.A2226@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <E16K1bW-0001K0-00@the-village.bc.nu> <20011228223604.A370@elektroni.ee.tut.fi> <a0j9i2$tkr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a0j9i2$tkr$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Dec 28, 2001 at 06:25:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 06:25:06PM -0800, H. Peter Anvin wrote:
> Machine/motherboard/chipset/BIOS info?

I don't know if this is needed any more, in case Alan has a pending patch
already. But none of my three home machines can boot 2.2.20 zImages from
LILO:

486 (133 MHz): motherboard MG-PCI 486, chipset UMC880, AMIBIOS from year
1993.

pentium (MMX 150 MHz): IBM Thinkpad 310 E.

athlon (TB 1400 MHz): motherboard Abit KG7-RAID, AMD760/VIA686, Award BIOS.
