Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUAEPKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAEPKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:10:02 -0500
Received: from mail.aei.ca ([206.123.6.14]:33266 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261406AbUAEPJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:09:50 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Subject: Re: 2.6.0 performance problems
Date: Mon, 5 Jan 2004 10:09:46 -0500
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org
References: <87brpq7ct3.wl@canopus.ns.zel.ru> <200312300855.00741.edt@aei.ca> <87smiud180.wl@canopus.ns.zel.ru>
In-Reply-To: <87smiud180.wl@canopus.ns.zel.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401051009.46293.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 05, 2004 07:33 am, Samium Gromoff wrote:
> At Tue, 30 Dec 2003 08:55:00 -0500,
>
> Ed Tomlinson wrote:
> > On December 30, 2003 06:41 am, Samium Gromoff wrote:
> > > Reality sucks.
> > >
> > > People are ignorant enough to turn blind eye to obvious vm regressions.
> > >
> > > No developers run 64M boxens anymore...
> >
> > No one is turning a blind eye.  Notice Linus has reponded to and is
> > interested in this thread.  The vm is not perfect in all cases - in most
> > cases it is faster though...
>
> "in most cases it is faster" is a big lie.
>
> The reality is: on all usual one-way boxes 2.6 goes slower than 2.4 once
> you start paging.

I would argue that in most case you do not page or page very little - know that is 
the case here.

In any case it does point out what part of the system needs to be improved.

Ed
