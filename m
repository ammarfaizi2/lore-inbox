Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTARNVp>; Sat, 18 Jan 2003 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTARNVp>; Sat, 18 Jan 2003 08:21:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4271 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264705AbTARNVo>;
	Sat, 18 Jan 2003 08:21:44 -0500
Date: Sat, 18 Jan 2003 13:28:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Mark F." <daracerz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 - Compaq 900z - No Go..
Message-ID: <20030118132807.GC21489@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Mark F." <daracerz@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY2-DAV69nJkxWwBvt0000440f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY2-DAV69nJkxWwBvt0000440f@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 11:49:10AM -0500, Mark F. wrote:
 > Hello
 > 
 > After trying the recent latest release, the compilation mode is an ok except
 > for some warning and module install issues.
 > Anyways, when I configure the kernel into the boot loader, and I try to boot
 > it up it fails after each repeated attempt.  All that happens is that it
 > starts the Kernel Boot Up, gets to the line that says "Uncompressing
 > Kernel...." and the it just hard reboots the computer.  Does this after each
 > repeated chance.  Currently trying to play around with whch drivers I am
 > loading into the kernel to see if I am able to eliminate something
 > 
 > Computer is basically an AMD Athlon 1600 with the Radeon IGP Chipset for
 > those who don't know.  (Yes, with previous builds, think was 2.5.54 is
 > booted, and works on 2.4.21-pre3)

My Compaq Evo 1015v did the same thing. I think it was disabling the PNP
stuff that made it work for me iirc.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
