Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVAMQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVAMQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVAMQnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:43:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27876 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261224AbVAMQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:40:57 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112174203.GA691@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105627541.4624.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
> The kernel security list must be higher in hierarchy than vendorsec.
> 
> Any information sent to vendorsec must be sent immediately for the kernel
> security list and discussed there.

We cannot do this without the reporters permission. Often we get
material that even the list isn't allowed to directly see only by
contacting the relevant bodies directly as well. The list then just
serves as a "foo should have told you about issue X" notification.

If you are setting up the list also make sure its entirely encrypted
after the previous sniffing incident.

Alan

