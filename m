Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCaINr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCaINr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCaINr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:13:47 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:24281 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751260AbWCaINr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:13:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Fri, 31 Mar 2006 10:12:28 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603301413.06408.rjw@sisk.pl> <200603310914.43512.ncunningham@cyclades.com>
In-Reply-To: <200603310914.43512.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311012.29491.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 01:14, Nigel Cunningham wrote:
> On Thursday 30 March 2006 22:13, Rafael J. Wysocki wrote:
> > On Thursday 30 March 2006 11:39, Nigel Cunningham wrote:
> > > On Thursday 30 March 2006 19:34, Rafael J. Wysocki wrote:
> > > > On Wednesday 29 March 2006 12:50, Nigel Cunningham wrote:
> > > > > Don't bother suggesting that to x86_64 owners: compilation is
> > > > > currently broken in vbetool/lrmi.c (at least).
> > >
> > > I get:
> >
> > Please try the Makefile that I use on x86_64 (attached).
> 
> Am I right in guessing that I don't need to anymore, given the other emails on 
> this thread?

Yes, you are. :-)

Greetings,
Rafael
