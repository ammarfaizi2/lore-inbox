Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbTGJMAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269228AbTGJMAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:00:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24234 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269226AbTGJMAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:00:51 -0400
Date: Thu, 10 Jul 2003 09:13:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: RFC:  what's in a stable series?
In-Reply-To: <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>
References: <3F0CBC08.1060201@pobox.com>  <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
  <20030710085338.C28672@infradead.org> <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus removed from CC because I think he does not care about 2.4.x
specific issues - which is what this thread is now about.

On Thu, 10 Jul 2003, Alan Cox wrote:

> On Iau, 2003-07-10 at 08:53, Christoph Hellwig wrote:
> > Also the quota patches don't change any ABI or API - userland can still
> > use the old ABI in addition to the new one, 16bit ondisk quotas are
> > still supported and filesystems couldn't care less which implementation
> > it plugs into - the API is the same.
>
> Because you hacked v1 support out of Jan Kara's stuff the quota bits are
> pretty useless to most people because they have v1 format files.

So Christoph's quota patch does not support vendors "v1" files?

I must be misunderstanding someone.


