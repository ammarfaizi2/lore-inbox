Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWADObU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWADObU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWADObT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:31:19 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:55272 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932099AbWADObT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:31:19 -0500
Subject: Re: 2.6.15-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0601031922020.1339@gandalf.stny.rr.com>
References: <20060103094720.GA16497@elte.hu>
	 <20060103153317.26a512fa@mango.fruits.de>
	 <20060103161356.4e1b47e0@mango.fruits.de>
	 <1136313652.6039.171.camel@localhost.localdomain>
	 <1136314600.6039.174.camel@localhost.localdomain>
	 <20060104010138.060c8a32@mango.fruits.de>
	 <Pine.LNX.4.58.0601031922020.1339@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 09:31:12 -0500
Message-Id: <1136385072.12468.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 19:24 -0500, Steven Rostedt wrote:
> On Wed, 4 Jan 2006, Florian Schmidt wrote:
> 
> > On Tue, 03 Jan 2006 13:56:40 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Well, with the patch, the above program has been running for over ten
> > > minutes without the race occurring.  Without the patch, the race happens
> > > in about one minute or less.
> >
> > It has yet to show up here, too. Thanks, looks good.
> >
> 
> I have yet to stop my test, and it has been running for over three hours
> now.  So I believe that this fixes that race.
> 

I let the test run all night, and it didn't bug once.

-- Steve

