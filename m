Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290586AbSAYHei>; Fri, 25 Jan 2002 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290592AbSAYHe3>; Fri, 25 Jan 2002 02:34:29 -0500
Received: from [62.14.144.134] ([62.14.144.134]:51716 "EHLO ragnar-hojland.com")
	by vger.kernel.org with ESMTP id <S290591AbSAYHeS>;
	Fri, 25 Jan 2002 02:34:18 -0500
Date: Fri, 25 Jan 2002 08:33:43 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which version of glibc?
Message-ID: <20020125083343.B2313@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.33.0201231042130.16094-100000@speech.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201231042130.16094-100000@speech.corp.fedex.com>; from jeffchua@silk.corp.fedex.com on Wed, Jan 23, 2002 at 10:47:30AM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 10:47:30AM -0800, Jeff Chua wrote:
> 
> Should I upgrade to glibc-2.2.5 for linux kernel compilation?
> 
> I'm on gcc-2.95.3, glibc-2.1.3
> 
> What about gcc?

Follow Ketils advice :)

> I'm asking this now as Xfree86 is just release and it's build with glib22.

Upgrading glibc to 2.2 now is a good idea.  2.1.3 had some sort of
floating point bug, and I'm not all sure it had full support for big files.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
