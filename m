Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTALPtk>; Sun, 12 Jan 2003 10:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTALPtk>; Sun, 12 Jan 2003 10:49:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5782
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267179AbTALPtj>; Sun, 12 Jan 2003 10:49:39 -0500
Subject: Re: Intel And Kenrel Programming (was: Nvidia is a great company)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: robw@optonline.net
Cc: Chuck Wolber <chuckw@quantumlinux.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042382565.848.11.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301112346450.2270-100000@bailey.scraps.org>
	 <1042382565.848.11.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042389923.15051.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 16:45:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 14:42, Rob Wilkens wrote:
> Ignorring the well popularized floating point bug in the pentium, to
> which there was a bug, are there many other bugs you run accross in the
> pentium while kernel programming?

There are actually very few chips we don't have to deal with some kind
of errata on, and the newer more complex chips generally have the larger
collections of errata. 

One thing that has been helpful is the microcode update stuff Intel did, we
hit  few bugs that up to date microcode kill off

