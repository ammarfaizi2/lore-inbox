Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTALWZ7>; Sun, 12 Jan 2003 17:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTALWZ7>; Sun, 12 Jan 2003 17:25:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61590
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267564AbTALWZ5>; Sun, 12 Jan 2003 17:25:57 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: robw@optonline.net
Cc: Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042409562.1209.142.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
	 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
	 <20030112211530.GP27709@mea-ext.zmailer.org>
	 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
	 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
	 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
	 <32929.62.98.226.220.1042408728.squirrel@webmail.roma2.infn.it>
	 <1042409562.1209.142.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042413711.16288.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 23:21:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 22:12, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 16:58, Emiliano Gabrielli wrote:
> > you do, if you inline the code and every drive writer use this tecnique the kernel will
> > be much bigger don't you think ?!?
> 
> Kernel size (footprint in memory) would grow a tad bit (not much), but
> it's overall speed would also go up.  

Wrong. Thats the trouble with programming an abstract level. People just don't
understand the real world. Cache is everything, small cache footprint is king.

Alan

