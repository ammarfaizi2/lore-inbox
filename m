Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSGFXRd>; Sat, 6 Jul 2002 19:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSGFXRc>; Sat, 6 Jul 2002 19:17:32 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:43274 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313060AbSGFXRc>; Sat, 6 Jul 2002 19:17:32 -0400
Date: Sun, 7 Jul 2002 00:20:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020707002006.B5242@flint.arm.linux.org.uk>
References: <003201c224cd$e25df820$0201a8c0@witek> <jen0t4g35k.fsf@sykes.suse.de> <20020706221205.A5242@flint.arm.linux.org.uk> <ag7q77$en7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ag7q77$en7$1@cesium.transmeta.com>; from hpa@zytor.com on Sat, Jul 06, 2002 at 03:16:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 03:16:07PM -0700, H. Peter Anvin wrote:
> /proc/cpuinfo was *definitely* meant to be parsed by programs.
> Unfortunately, lots of architectures seems to have completely missed
> that fact.

Sigh, its a shame such things aren't documented somewhere in the
kernel tarball.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

