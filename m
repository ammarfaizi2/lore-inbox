Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUEEDxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUEEDxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 23:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUEEDxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 23:53:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:36762 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261576AbUEEDxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 23:53:37 -0400
Date: Tue, 4 May 2004 19:56:02 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-ID: <20040505025602.GA19873@kroah.com>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com> <s5gy8o7bnhv.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gy8o7bnhv.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 10:49:56PM -0400, Patrick J. LoPresti wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Tue, May 04, 2004 at 05:56:48PM -0400, Patrick J. LoPresti wrote:
> >
> > > But what if it fails to bind?  For example, what if an error occurs?
> > > Or what if the keyboard is on the module's blacklist?  How do I know
> > > when to stop waiting?
> > 
> > You do not, sorry.
> 
> That is disappointing.  I mean, I deal with Microsoft products a lot,
> where "unreliable by design" is normal.  But I expected better from
> Linux.

That is such an obvious troll and flame bait, I really do not know why I
am responding.  Please, try to be civil here.  The point of Linux isis,
if you don't like the way things are today, you can change them.  Try
that with Microsoft products (for that manner, please show me how you
can do what you are trying to do on Windows 2000, driver stuff there is
_so_ much more complex...)

But before you try to do that (which basically is moving things back to
the way things used to be years ago in 2.2), why don't you try to state
the problem you are having.  Perhaps it can be solved in a different
manner than what you are trying to do.

So, what are you trying to fix/solve/monitor/do here?

thanks,

greg k-h
