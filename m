Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287957AbSABXKO>; Wed, 2 Jan 2002 18:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287184AbSABXKF>; Wed, 2 Jan 2002 18:10:05 -0500
Received: from dialin-145-254-151-098.arcor-ip.net ([145.254.151.98]:34326
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S287181AbSABXJv>; Wed, 2 Jan 2002 18:09:51 -0500
Message-ID: <3C339284.3F88FE68@loewe-komp.de>
Date: Thu, 03 Jan 2002 00:06:44 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: robert@schwebel.de
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201021823210.3056-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel schrieb:
> 
> On Wed, 2 Jan 2002, Robert Schwebel wrote:
> > I've already searched through all manuals I could find on the AMD site
> > (http://www.amd.com/epd/processors/4.32bitcont/13.lan4xxfam/23.lansc410/index.html)
> > but couldn't find anything related to the CPUID command...
> 
> Aaargh, does anyone have a brown paper bag for me? The infomration is in
> the User Manual.
> 
> Model  0ah means "enhanced Am486 SX1 write back mode"
> Family 04h means "Am486 CPU"
> 
> Which IMHO doesn't say that this combination means _exactly_ the SC410.
> 

IIRC the difference between SC410 and SC400 is an embedded PCMCIA controller
and perhaps a LCD controller.
The CPU core should be the same.
