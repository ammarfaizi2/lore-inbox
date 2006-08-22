Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWHVVel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHVVel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWHVVel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:34:41 -0400
Received: from xenotime.net ([66.160.160.81]:18655 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751300AbWHVVek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:34:40 -0400
Date: Tue, 22 Aug 2006 14:37:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-Id: <20060822143747.68acaf99.rdunlap@xenotime.net>
In-Reply-To: <1156281182.2476.63.camel@entropy>
References: <11561555871530@2ka.mipt.ru>
	<1156230051.8055.27.camel@entropy>
	<20060822072448.GA5126@2ka.mipt.ru>
	<1156234672.8055.51.camel@entropy>
	<20060822083711.GA26183@2ka.mipt.ru>
	<1156238988.8055.78.camel@entropy>
	<20060822100316.GA31820@2ka.mipt.ru>
	<1156276658.2476.21.camel@entropy>
	<20060822201646.GC3476@2ka.mipt.ru>
	<1156281182.2476.63.camel@entropy>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 14:13:02 -0700 Nicholas Miell wrote:

> On Wed, 2006-08-23 at 00:16 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 22, 2006 at 12:57:38PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > On Tue, 2006-08-22 at 14:03 +0400, Evgeniy Polyakov wrote:
> > > Of course, since you already know how all this stuff is supposed to
> > > work, you could maybe write it down somewhere?
> > 
> > I will write documantation, but as you can see some interfaces are
> > changed.
> 
> Thanks; rapidly changing interfaces need good documentation even more
> than stable interfaces simply because reverse engineering the intended
> API from a changing implementation becomes even more difficult.

OK, I don't quite get it.
Can you be precise about what you would like?

a.  good documentation
b.  a POSIX API
c.  a Windows-compatible API
d.  other?

and we won't make you use any of this code.

---
~Randy
