Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272963AbTGaKAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272960AbTGaKAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:00:02 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:64159 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272963AbTGaJ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:57:24 -0400
Date: Thu, 31 Jul 2003 11:57:13 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: Keith Owens <kaos@ocs.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030731095713.GL12849@louise.pinerecords.com>
References: <20030731091909.GK12849@louise.pinerecords.com> <Pine.LNX.4.33.0307311149110.11927-100000@urtica.linuxnews.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0307311149110.11927-100000@urtica.linuxnews.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [pkot@linuxnews.pl]
> 
> > > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > >I don't want to require zlib, though.  The modutils I have (Debian)
> > > >doesn't support it, either.
> > >
> > > Really?  modutils 2.4: ./configure --enable-zlib
> >
> > Keith, I believe Rusty meant the standard Debian package had binaries
> > compiled w/o '--enable-zlib'.
> >
> > (And so has Slackware btw.)
> 
> Slackware since 8.0 uses compression for the kernel modules by
> default and uses --enable-zlib for modutils.
> See:
> ftp://ftp.slackware.com/pub/slackware/slackware-9.0/source/a/modutils/modutils.SlackBuild

Hmmm, things change. :)
Thanks for correcting me.

-- 
Tomas Szepe <szepe@pinerecords.com>
