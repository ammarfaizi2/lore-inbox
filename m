Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTESWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTESWl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:41:28 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:30102 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263195AbTESWl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:41:26 -0400
Date: Mon, 19 May 2003 23:57:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: D & E Radel <radel@inet.net.nz>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org,
       Flavio Stanchina <flavio.stanchina@tin.it>,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Subject: Re: AGP Kernel Patch for VIA KM266 / KL266
Message-ID: <20030519225739.GA16521@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	D & E Radel <radel@inet.net.nz>, alan@redhat.com,
	linux-kernel@vger.kernel.org,
	Flavio Stanchina <flavio.stanchina@tin.it>,
	Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
References: <002101c31e58$9881bae0$1d687cca@xp1800>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002101c31e58$9881bae0$1d687cca@xp1800>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 10:47:10AM +1200, D & E Radel wrote:

 > With much help from Nicolas Mailhot and Flavio Stanchina, I have tested a 
 > Kernel 2.4.20 patch for AGP support for the VIA KM266 / KL266. It 
 > patches cleanly, compiles and runs in full 3D H/W acceleration with my 
 > ATI Radeon 9000.
 > 
 > Who do I send this to so that it can be included in the kernel?

marcelo@conectiva.com.br, Cc: Alan.

Slight nitpick...

 > Linux agpgart interface v0.99 (c) Jeff Hartmann
 > agpgart: Maximum main memory to use for agp memory: 203M
 > agpgart: Detected Via Apollo Pro KM266 / KL266 chipset
                     ^^^
s/Via/VIA/

		Dave

