Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTGOS7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269595AbTGOS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:59:34 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:23712 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269589AbTGOS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:59:24 -0400
Date: Tue, 15 Jul 2003 20:13:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: James Simmons <jsimmons@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030715191328.GB20424@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	James Simmons <jsimmons@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307151833310.7746-100000@phoenix.infradead.org> <20030715175758.GC15505@suse.de> <20030715184909.GD8240@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715184909.GD8240@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:49:09PM +0200, J?rn Engel wrote:

 > > One bug at a time. With the CONFIG_EMBEDDED hack, yes it will 'hide'
 > > this problem, but it'll likely be many months before embedded folks
 > > start thinking of using 2.6 anyways.
 > s/many month/half a second/
 > 
 > Even for embedded, 2.[56] is so much nicer that I wouldn't want to do
 > any new project with 2.4 anymore.  Continue the old ones, all right,
 > but that's about it.

Sorry, any vendor contemplating shipping 2.6test in a device at this stage
is a lunatic.  I don't care about lunatics.  As we saw recently there
are a lot of wireless routers and the like out there all stuck on some
magical 2.4.5 kernel. That sucks, but it's at least better than putting
beta quality code in something people pay money for.

		Dave

