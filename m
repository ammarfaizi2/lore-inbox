Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268292AbTBSBv0>; Tue, 18 Feb 2003 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbTBSBv0>; Tue, 18 Feb 2003 20:51:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20619
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268292AbTBSBvZ>; Tue, 18 Feb 2003 20:51:25 -0500
Subject: Re: a really annoying feature of the config menu structure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E52DE8B.6040002@verizon.net>
References: <Pine.LNX.4.44.0302181604310.23007-100000@dell>
	 <3E52B4CE.7040009@verizon.net>
	 <1045619804.25795.14.camel@irongate.swansea.linux.org.uk>
	 <3E52DE8B.6040002@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045623798.25795.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 03:03:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 01:31, Stephen Wille Padnos wrote:
> It seems that the mjpeg stuff will be in the wrong place when it starts 
> being used by non-DVB modules.  I see the two (DVB and mjpeg) as 
> distinct entities - like ethernet drivers and ipv4.  (DVB drivers should 
> let you change channels and whatnot, mjpeg drivers should allow you to 
> decode data streams from any available source.)

Its more by API than by hardware. One driver sometimes covers cards with
and without tuners, with and without mpeg hardware and so on. Classification
is nice, but like biology its never neat

