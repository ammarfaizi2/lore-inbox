Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVAOC5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVAOC5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAOC5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:57:05 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:22687 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S262160AbVAOC4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:56:52 -0500
In-Reply-To: <1105748095.9838.88.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain> <20050113210229.GG24970@beowulf.thanes.org> <20050113213002.GI3555@redhat.com> <20050113214814.GA9481@beowulf.thanes.org> <20050113220652.GJ3555@redhat.com> <Pine.LNX.4.61.0501140020470.2867@dragon.hygekrogen.localhost> <1105748095.9838.88.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0EE1CD25-66A1-11D9-B433-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Marek Habersack <grendel@caudium.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Jesper Juhl <juhl-lkml@dif.dk>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: thoughts on kernel security issues
Date: Sat, 15 Jan 2005 03:56:30 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-01-15, at 01:34, Alan Cox wrote:
> Its also about -risk- levels and the sum of risk to all parties
> involved.
Rather "Its also about price levels and the sum of costs to all parties 
involved."

For example if you share the costs of 5000 lines of code with millions 
of people
you can afford to pay the costs of developing them in a way which 
really assures safety.
Think about the software controlling a servo motor in your car...

You can't neglect economics when thinking about security issues, because
costs are the "metric" of this "space". If you don't like dollars just 
think about an even more
precise currency you have to pay with anyway: developer time.

Its simply expensive to develop well working code. And on the other 
hand buggy code is not bad in itself. Its just that cheap...

