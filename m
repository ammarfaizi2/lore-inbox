Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVAMUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVAMUap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAMU2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:28:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21221 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261469AbVAMUYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:24:25 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grendel@caudium.net
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113194246.GC24970@beowulf.thanes.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105643984.5193.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 19:19:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 19:42, Marek Habersack wrote:
> On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
> > We cannot do this without the reporters permission. Often we get
> I think I don't understand that. A reporter doesn't "own" the bug - not the
> copyright, not the code, so how come they can own the fix/report?

They own the report. Who owns it is kind of irrelevant. If we publish it
when they don't want it published then next time they'll send it to
full-disclosure or worse still just share an exploit with the bad guys.
So unless we get really stoopid requests we try not to annoy people -
hole reporting is a volunatry activity

> > material that even the list isn't allowed to directly see only by
> > contacting the relevant bodies directly as well. The list then just
> > serves as a "foo should have told you about issue X" notification.
> This sounds crazy. I understand that this may happen with proprietary
> software, or software that is made/supported by a company but otherwise opensource
> (like OpenOffice, for instance), but the kernel?

Its not uncommon. Not all security bodies (especially government
security agencies) trust vendor-sec directly, only some members on the
basis of their own private auditing/background checks.

Alan


