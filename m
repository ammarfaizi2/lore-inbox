Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVANKWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVANKWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVANKWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:22:55 -0500
Received: from levante.wiggy.net ([195.85.225.139]:1175 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261936AbVANKWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:22:54 -0500
Date: Fri, 14 Jan 2005 11:22:49 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050114102249.GA3539@wiggy.net>
Mail-Followup-To: Marek Habersack <grendel@caudium.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <1105643984.5193.95.camel@localhost.localdomain> <20050113204415.GF24970@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113204415.GF24970@beowulf.thanes.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Marek Habersack wrote:
> So it sounds that we, the men-in-the-crowd are really left out in the crowd,
> people who are affected the most by the issues. Since the vendors are not
> affected by the bugs (playing a devil's advocate here), since they fix them
> for their machines as they appear, way before they get public.

vendor suffer from that as well. Suppose vendors learn of a problem in
a product they visibly use such as apache or rsync. If all vendors
suddenly update their versions or disable things that will be noticed as
well, so vendors can't do that.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
