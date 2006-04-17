Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDQUZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDQUZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWDQUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:25:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53227 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750822AbWDQUZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:25:01 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060417202037.GB3615@sorel.sous-sol.org>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417202037.GB3615@sorel.sous-sol.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 22:24:53 +0200
Message-Id: <1145305493.2847.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 13:20 -0700, Chris Wright wrote:
> * James Morris (jmorris@namei.org) wrote:
> > How about enough time to get us to 2.6.18, say, two months?
> 
> Based on the discussions we had last year, I think the fair date would
> be August not June.

why?
this is already a year notice...
lets get it over with.. notice goes in now
removal to -mm, goes into 2.6.18

as it is its one helluva hook for the rootkit guys with only pain on the
kernel side (eg selinux) because of the super abstraction.


