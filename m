Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUGNQH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUGNQH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUGNQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:07:58 -0400
Received: from mout1.freenet.de ([194.97.50.132]:63377 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S264973AbUGNQHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:07:50 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [Q] don't allow tmpfs to page out
Date: Wed, 14 Jul 2004 18:07:08 +0200
User-Agent: KMail/1.6.2
References: <200407141654.31817.mbuesch@freenet.de> <200407141803.21388.mbuesch@freenet.de> <20040714160421.GD22641@devserv.devel.redhat.com>
In-Reply-To: <20040714160421.GD22641@devserv.devel.redhat.com>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407141807.11086.mbuesch@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven <arjanv@redhat.com>:
> On Wed, Jul 14, 2004 at 06:03:18PM +0200, Michael Buesch wrote:
> > >
> > > which is why there is ramfs .. :)
> >
> > In 2.4, too? Can't find it.
> > What's the CONFIG_* of ramfs?
>
> CONFIG_RAMFS

Ok, that's the thing /dev/ram* is about, isn't it?
I already have a /dev/ram mounted somewhere, but it's
not dynamic in size. What am I missing. I'm kind of
confused now. :)

--
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


