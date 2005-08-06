Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbVHFWUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbVHFWUx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 18:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbVHFWUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 18:20:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42401 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263605AbVHFWUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 18:20:51 -0400
Subject: Re: DRM VIA driver on Unichrome Pro K8M800
From: Lee Revell <rlrevell@joe-job.com>
To: Joris van Rantwijk <jvrantwijk@xs4all.nl>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <20050806192647.GA11937@xs4all.nl>
References: <fa.f66affe.52avgq@ifi.uio.no>
	 <20050806192647.GA11937@xs4all.nl>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 18:20:50 -0400
Message-Id: <1123366850.14113.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 21:26 +0200, Joris van Rantwijk wrote:
> Hello David,
> 
> I noticed you guided the VIA DRM driver into linux-2.6.13-rc3. Are you
> the right person to send questions/problems/patches about this driver?
> 
> I am trying to get it to run on my Unichrome Pro K8M800 chipset and
> it finally seems to be working (a bit) now.

FWIW, this is working great with my CLE266 chipset.

[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized via 2.6.3 20050523 on minor 0: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode

Lee

