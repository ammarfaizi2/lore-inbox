Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWDQUyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDQUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDQUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:54:16 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36739 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751265AbWDQUyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:54:15 -0400
Date: Mon, 17 Apr 2006 13:53:53 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060417205353.GE3615@sorel.sous-sol.org>
References: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417202037.GB3615@sorel.sous-sol.org> <1145305493.2847.86.camel@laptopd505.fenrus.org> <20060417202751.GC3615@sorel.sous-sol.org> <20060417203410.GA16886@kroah.com> <1145306636.2847.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145306636.2847.88.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> I still think at least in -mm the patch to remove it should go in early,
> just to make sure it'll be a smooth transition.

Sure
