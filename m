Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbRCAPCg>; Thu, 1 Mar 2001 10:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRCAPC1>; Thu, 1 Mar 2001 10:02:27 -0500
Received: from firewall.spacetec.no ([192.51.5.5]:57025 "EHLO
	pallas.spacetec.no") by vger.kernel.org with ESMTP
	id <S129619AbRCAPCP>; Thu, 1 Mar 2001 10:02:15 -0500
Date: Thu, 1 Mar 2001 16:02:11 +0100
Message-Id: <200103011502.QAA25429@pallas.spacetec.no>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
In-Reply-To: <fa.o4k0c0v.smgv2v@ifi.uio.no>
    <fa.m9jgfcv.17n8s2n@ifi.uio.no>
In-Reply-To: <fa.m9jgfcv.17n8s2n@ifi.uio.no>
From: tor@spacetec.no (Tor Arntsen)
Subject: Re: Will Mosix go into the standard kernel?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Ridge <newt@scyld.com> writes:
[...]
>Compare this total volume to the thousands of lines of patches that
>RedHat or VA add to their kernel RPMS before shipping. I just don't see 
[...]

What's good about that?  The first thing I do is to rip out the RedHat
kernel and compile and install a pure kernel from ftp.kernel.org. 
It's *bad* that those vendors deliver hacked kernels.  It's not
something that should be recommended as a *goal*!
When I need a new kernel version I can't sit back and hope with 
crossed fingers that RedHat (or whatever vendor) comes out with a 
new, hacked version of Linus' latest.

-Tor
