Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTGOTPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTGOTPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:15:17 -0400
Received: from [213.39.233.138] ([213.39.233.138]:17619 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269619AbTGOTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:15:13 -0400
Date: Tue, 15 Jul 2003 21:28:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030715192853.GE8240@wohnheim.fh-wedel.de>
References: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org> <20030715175758.GC15505@suse.de> <20030715184909.GD8240@wohnheim.fh-wedel.de> <20030715191328.GB20424@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030715191328.GB20424@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 July 2003 20:13:28 +0100, Dave Jones wrote:
> 
> Sorry, any vendor contemplating shipping 2.6test in a device at this stage
> is a lunatic.  I don't care about lunatics.  As we saw recently there
> are a lot of wireless routers and the like out there all stuck on some
> magical 2.4.5 kernel. That sucks, but it's at least better than putting
> beta quality code in something people pay money for.

Well, the good old embedded process is this:

Take what's availlable (2.4.5 then).
Adapt to the hardware.
Test for a while.
Ship it.
Don't touch it anymore.

So what is lunatic about doing the same with 2.6test?  It may make the
test a little more expensive, but the adaptation will be cheaper, so
you are just about even.  And the result is no less frightening than a
2.4.2 kernel with various backports from 2.4.younameit, and even more
quick hacks.

The only thing we agree on is that it would be loony to port known
working hardware to a newer kernel.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
