Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSKPK1h>; Sat, 16 Nov 2002 05:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSKPK1h>; Sat, 16 Nov 2002 05:27:37 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:39191
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267257AbSKPK1g>; Sat, 16 Nov 2002 05:27:36 -0500
Date: Sat, 16 Nov 2002 05:37:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Greg Kroah-Hartmann <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] USB core/urb.c triggers slab bugcheck
In-Reply-To: <Pine.LNX.4.44.0211160455040.1810-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211160536380.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Zwane Mwaikambo wrote:

> This patch is also required to get my box to boot
> 
> kernel BUG at mm/slab.c:1619!
> invalid operand: 0000

Sorry please ignore this one, the first patch fixed the boot problem, i 
hadn't tried booting with it alone. This must have been fallout.

Zwane

-- 
function.linuxpower.ca

