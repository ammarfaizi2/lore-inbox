Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSLGSQj>; Sat, 7 Dec 2002 13:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLGSQj>; Sat, 7 Dec 2002 13:16:39 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24161
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264622AbSLGSQj>; Sat, 7 Dec 2002 13:16:39 -0500
Date: Sat, 7 Dec 2002 13:24:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Adam Belay <ambx1@neo.rr.com>
cc: greg@kroah.com, "" <perex@suse.cz>, "" <linux-kernel@vger.kernel.org>,
       "" <pelaufer@adelphia.net>
Subject: Re: [PATCH] Linux PnP Support V0.93 - 2.5.50
In-Reply-To: <20021201143221.GC333@neo.rr.com>
Message-ID: <Pine.LNX.4.50.0212071322230.3130-100000@montezuma.mastecende.com>
References: <20021201143221.GC333@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Adam Belay wrote:

> Attached is a patch, gzipped for size, that updates the 2.5.50 to the latest pnp
> version.  It includes all 9 of the previously submitted patches.
>
> Highlights are as follows:
> -PnP BIOS fixes
> -Several new macros
> -PnP Card Services
> -Various bug fixes
> -more drivers converted to the new APIs
>
> PnP developers please use this patch.

Could we get a void* in pnp_dev? I'm finding myself resorting to
driver internal arrays in order to track locations of device private structures.

Thanks,
	Zwane
-- 
function.linuxpower.ca
