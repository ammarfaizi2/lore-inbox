Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbSJUGf3>; Mon, 21 Oct 2002 02:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJUGf3>; Mon, 21 Oct 2002 02:35:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46855 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264754AbSJUGf2>; Mon, 21 Oct 2002 02:35:28 -0400
Message-Id: <200210210636.g9L6a7p20939@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Thomas Molina <tmolina@cox.net>, Mike Galbraith <efault@gmx.de>
Subject: Re: loadlin with 2.5.?? kernels
Date: Mon, 21 Oct 2002 09:28:54 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210201357050.8843-100000@dad.molina>
In-Reply-To: <Pine.LNX.4.44.0210201357050.8843-100000@dad.molina>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 October 2002 16:58, Thomas Molina wrote:
> On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > At 08:17 AM 10/20/2002 -0500, Thomas Molina wrote:
> > >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > > > Greetings,
> > > >
> > > > I hadn't had time to build/test kernels since 2.5.8-pre3.  I
> > > > now find that loadlin doesn't work on my box any more.  Is this
> > > > a known problem?  If so, when did it quit working?  (loadlin
> > > > obsolete?  other?)
> > >
> > >I'm carrying an open problem report from Rene Blokland on this
> > > issue. What version of the kernel did you try?
> >
> > Only 2.5.42.virgin, 2.5.42-mm, 2.5.43-mm and 2.5.44.virgin.  Binary
> > search pending.
>
> The report stated the problem was noted with 2.5.4x.  One of the
> developers might want to speak up as to whether finding the exact
> point of breakage is useful.

Shameless plug time.

http://port-ilyichevsk.com.ua/linux/vda/linld/

linld095.tar.bz2 does contain source.

Get *devel.tar.bz2 only if you _don't have Borland C_ and want to recompile.
--
vda
