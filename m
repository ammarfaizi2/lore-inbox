Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVAMRAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVAMRAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVAMQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:42:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32996 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261228AbVAMQlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:10 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112182838.2aa7eec2.akpm@osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105627639.4644.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 02:28, Andrew Morton wrote:
> For the above reasons I see no need to delay publication of local DoS holes
> at all.  The only thing for which we need to provide special processing is
> privilege escalation bugs.
> 
> Or am I missing something?

Universities and web hosting companys see the DoS issue rather
differently sometimes. (Once we have Xen in the tree we'll have a good
answer)

