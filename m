Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTBVTaz>; Sat, 22 Feb 2003 14:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTBVTaz>; Sat, 22 Feb 2003 14:30:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42882
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267286AbTBVTay>; Sat, 22 Feb 2003 14:30:54 -0500
Subject: Re: 2.4.20-ac1 not seeing IDE disk on PIIX host adapter
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030222085102.GA23966@torres.ka0.zugschlus.de>
References: <20030222085102.GA23966@torres.ka0.zugschlus.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045946551.5484.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 20:42:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 08:51, Marc Haber wrote:
> Linux 2.4.20-ac1 sees the PIIX chip, but not the disks connected to
> it. This of course results in a kernel panic "unable to mount root
> fs". Same thing happens with 2.4.20-ac2. Vanilla 2.4.20 works fine. Of
> course, all kernels have been built with the same configuration.

I'd like to know if 2.4.21pre4-ac6 sees the disks. You don't even need
to run it beyond the boot, just to check this is the legacy port
problem.

