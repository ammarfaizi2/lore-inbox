Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWC3JgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWC3JgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWC3JgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:36:13 -0500
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:46604 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932145AbWC3JgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:36:12 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 11:35:05 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       suspend2-announce@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603292050.33622.ncunningham@cyclades.com> <20060330092627.GG8485@elf.ucw.cz>
In-Reply-To: <20060330092627.GG8485@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603301135.05293.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 11:26, Pavel Machek wrote:
> On St 29-03-06 20:50:27, Nigel Cunningham wrote:
> > Hi.

> > > Please do try code at suspend.sf.net. It should be as fast and not
> > > needing big kernel patch.
> >
> > Don't bother suggesting that to x86_64 owners: compilation is currently
> > broken in vbetool/lrmi.c (at least).
>
> It seems to work at least for some users. I do not have x86-64 machine
> easily available, so someone else will have to fix that one.

It builds fine here on x86_64 with gcc 4.1.

> 								Pavel

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
