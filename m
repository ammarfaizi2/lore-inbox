Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVAMWdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVAMWdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:21:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47845 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261785AbVAMWUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:20:46 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, grendel@caudium.net,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113115004.Z24171@build.pdx.osdl.net>
	 <20050113202905.GD24970@beowulf.thanes.org>
	 <1105645267.4644.112.camel@localhost.localdomain>
	 <1105649837.6031.54.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105650940.5193.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 21:15:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 21:22, Linus Torvalds wrote:
> Are there advantages and upsides? Yes. Are there disadvantages?  
> Indubitably. And anybody who disregards the disadvantages as "inevitable"
> is not really interested in fixing the game.

So the next time I find a remote root hole I should post an exploit
example targetting kernel.org to the linux-kernel list ? Now where are
you going to publish the fix - bk is down, kernel.org is down ...


Disclosre isn't quite as simple as you'd like.
