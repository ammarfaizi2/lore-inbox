Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbSKPKf7>; Sat, 16 Nov 2002 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267262AbSKPKf7>; Sat, 16 Nov 2002 05:35:59 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:41495
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267261AbSKPKf6>; Sat, 16 Nov 2002 05:35:58 -0500
Date: Sat, 16 Nov 2002 05:46:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Oliver Neukum <oliver@neukum.name>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] USB core/urb.c triggers slab bugcheck
In-Reply-To: <200211161118.55733.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44.0211160544020.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Oliver Neukum wrote:

> Am Samstag, 16. November 2002 10:57 schrieb Zwane Mwaikambo:
> > This patch is also required to get my box to boot
> 
> Why is this needed ? I might be stupid, but it seems as if this patch
> changes nothing.

Au contraire, i'm the idiot, i had debugged all the oopses in one sitting 
without booting each 'fix', i was pretty certain that bug had been triggered 
seperately in an earlier boot.

	Zwane
-- 
function.linuxpower.ca

