Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTGOTrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269616AbTGOTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:47:18 -0400
Received: from [213.39.233.138] ([213.39.233.138]:40917 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269602AbTGOTrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:47:17 -0400
Date: Tue, 15 Jul 2003 22:00:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030715200048.GF8240@wohnheim.fh-wedel.de>
References: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org> <20030715175758.GC15505@suse.de> <20030715184909.GD8240@wohnheim.fh-wedel.de> <20030715191328.GB20424@suse.de> <20030715192853.GE8240@wohnheim.fh-wedel.de> <20030715193224.GE20424@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030715193224.GE20424@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 July 2003 20:32:24 +0100, Dave Jones wrote:
> On Tue, Jul 15, 2003 at 09:28:53PM +0200, J?rn Engel wrote:
> 
>  > So what is lunatic about doing the same with 2.6test?
> 
> Simple, there are known problems in 2.6.0test.
> At the time of embedded folks using 2.4.5, there were no known problems.

The VM was enough of a problem for one flamewar or another.  There is
even a faint memory of major construction work around 2.4.10.

You may be right for an x86 design that work out of the box, but I got
used to extensive adjustments and just as extensive test afterwards.
If those test are successful, the kernel is stable by definition,
whatever the known problems may be.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
