Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUICFFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUICFFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 01:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269543AbUICFFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 01:05:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269499AbUICFFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 01:05:13 -0400
Date: Fri, 3 Sep 2004 06:05:11 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Grzegorz Ja??kiewicz <gj@pointblue.com.pl>
Cc: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040903050511.GL23987@parcelfarce.linux.theplanet.co.uk>
References: <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <4137F669.2000505@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4137F669.2000505@pointblue.com.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 06:43:21AM +0200, Grzegorz Ja??kiewicz wrote:
> >Then I guess OS X ships a broken implementation of cp, yes?
> >
> Nope, GUI handles it perfectly. it's maybe 0.1% of users of MacOS that 
> acctually care about cp being broken.

Gotta love the Mac logics: "Is $FOO broken?" - "Nope, $BAR works. Very few
care about $FOO being broken".
