Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbTGJO5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbTGJO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:57:42 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:48145 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269312AbTGJO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:57:40 -0400
Date: Thu, 10 Jul 2003 16:12:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710161217.B22512@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva> <20030710085338.C28672@infradead.org> <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jul 10, 2003 at 09:13:03AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 09:13:03AM -0300, Marcelo Tosatti wrote:
> > Because you hacked v1 support out of Jan Kara's stuff the quota bits are
> > pretty useless to most people because they have v1 format files.
> 
> So Christoph's quota patch does not support vendors "v1" files?
> 
> I must be misunderstanding someone.

Alan obviously didn't even look at the code.  Of course the old
quota format is supported as described in the mail I sent you
the patch with.

