Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272439AbTGaJwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTGaJwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:52:53 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:20242 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP id S272439AbTGaJww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:52:52 -0400
Date: Thu, 31 Jul 2003 11:52:28 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Keith Owens <kaos@ocs.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools don't support gzipped modules.
In-Reply-To: <20030731091909.GK12849@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0307311149110.11927-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, Tomas Szepe wrote:

> > [kaos@ocs.com.au]
> >
> > On Thu, 31 Jul 2003 02:46:23 +1000,
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >I don't want to require zlib, though.  The modutils I have (Debian)
> > >doesn't support it, either.
> >
> > Really?  modutils 2.4: ./configure --enable-zlib
>
> Keith, I believe Rusty meant the standard Debian package had binaries
> compiled w/o '--enable-zlib'.
>
> (And so has Slackware btw.)

Slackware since 8.0 uses compression for the kernel modules by
default and uses --enable-zlib for modutils.
See:
ftp://ftp.slackware.com/pub/slackware/slackware-9.0/source/a/modutils/modutils.SlackBuild

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

