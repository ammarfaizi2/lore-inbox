Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVAMUDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVAMUDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVAMUCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:02:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13541 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261494AbVAMUBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:01:09 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Jones <davej@redhat.com>, grendel@caudium.net,
       Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113193524.GA27785@infradead.org>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050113032506.GB1212@redhat.com>
	 <20050113035331.GC9176@beowulf.thanes.org>
	 <1105627951.4664.32.camel@localhost.localdomain>
	 <20050113192512.GA27607@infradead.org> <20050113193356.GA3555@redhat.com>
	 <20050113193524.GA27785@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105642542.5193.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 18:55:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 19:35, Christoph Hellwig wrote:
> freudian typo, should have been smbfs as it should be obvious for the
> context I replied to.

It works in some situations but not others. Chuck Ebbert fixed this but
its never gotten upstream, although I think Andrew was now looking at
it.

