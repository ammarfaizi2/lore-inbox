Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUGIKEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUGIKEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUGIKDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:03:10 -0400
Received: from zulo.virutass.net ([62.151.20.186]:41885 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S264914AbUGIKCp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:02:45 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: Michael Buesch <mbuesch@freenet.de>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel fchown() exploit status?
Date: Fri, 9 Jul 2004 12:02:58 +0200
User-Agent: KMail/1.5
Cc: Chris White <webmaster@securesystem.info>
References: <40EDB764.6060107@securesystem.info> <20040708162414.I1973@build.pdx.osdl.net> <200407091146.32077.mbuesch@freenet.de>
In-Reply-To: <200407091146.32077.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200407091202.58377.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Viernes 09 Julio 2004 11:46, Michael Buesch escribió:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Quoting Chris Wright <chrisw@osdl.org>:
> > * Chris White (webmaster@securesystem.info) wrote:
> > > There was a recent security announcment regarding a vulnerability with
> > > the fchown function.
> > >
> > > Only a few distrobutions (red hat/suse) have fixed the issue, but I've
> > > yet to see a general patch for it.
> >
> > Patches are in both 2.4 and 2.6 bk trees.  2.4.27-rc3 has this fixed.
> > There hasn't been a 2.6.8-rc release since the patches went in to 2.6
>
> Is there an exploit available to test if the kernel has
> this vulnerability?

Look at this:
http://www.securityfocus.com/bid/10662/exploit/
It says that it's not exploit requiered to exploit this bug.

Any ideas,  Chris White?

Cheers

 
-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

