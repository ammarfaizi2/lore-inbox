Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273620AbRJDIpK>; Thu, 4 Oct 2001 04:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRJDIpB>; Thu, 4 Oct 2001 04:45:01 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:17026 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S272882AbRJDIos>; Thu, 4 Oct 2001 04:44:48 -0400
Date: Thu, 4 Oct 2001 18:45:04 +1000
From: CaT <cat@zip.com.au>
To: john slee <indigoid@higherplane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004184504.C512@zip.com.au>
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org> <20011004182127.B512@zip.com.au> <20011004183507.A29887@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011004183507.A29887@higherplane.net>; from indigoid@higherplane.net on Thu, Oct 04, 2001 at 06:35:07PM +1000
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 06:35:07PM +1000, john slee wrote:
> > Mind if I ask why you need a bzimage under 400kb? Just curious as I've
> > never had the need. (And I can see needing it less then 1.4meg - are you
> > trying to get a kernel AND a ramdisk on the one floppy?)
> 
> plenty of reasons.  i'm building a compactflash-based linux router which
> will only have 16mb of flash for the entire system... saving 100kb means
> you can fit a few extra userspace tools in there...
> 
> -rwxr-xr-x    1 indigoid indigoid    54444 Oct  4 18:30 boa*

Well, duh. :)

Thanks. :)

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
