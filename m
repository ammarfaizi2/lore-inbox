Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSE2PIy>; Wed, 29 May 2002 11:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSE2PIx>; Wed, 29 May 2002 11:08:53 -0400
Received: from ns.suse.de ([213.95.15.193]:37134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S312601AbSE2PIw>;
	Wed, 29 May 2002 11:08:52 -0400
Date: Wed, 29 May 2002 17:08:53 +0200
From: Dave Jones <davej@suse.de>
To: Corin Hartland-Swann <cdhs@commerce.uk.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: bluesmoke, machine check exception, reboot
Message-ID: <20020529170853.Q27463@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Corin Hartland-Swann <cdhs@commerce.uk.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0205280810240.1840-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33L2.0205291414210.19118-100000@buffy.commerce.uk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 02:46:51PM +0100, Corin Hartland-Swann wrote:
 > I ran it through parsemce as suggested (thanks Randy), and got the
 > following output:

parsemce lacks any command line parsing (I just never got around to it yet)
so you'll have to hack the values in the code at lines 200 or so to
match the values in your logs.

 > Also http://marc.theaimsgroup.com/?l=linux-kernel&m=101338603328639&w=2
 > mentions a tool decodemca - is that a previous name for parsemce?

At the time of that message no tool existed at all, once I got it to
the state its in now, I called it 'parse' instead of 'decode' for some
reason. There is no alternative tool, just a thinko on my part.

    Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
