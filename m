Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbTGJO4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbTGJO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:56:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:46609 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269301AbTGJO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:56:53 -0400
Date: Thu, 10 Jul 2003 16:11:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710161127.A22512@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@osdl.org>
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva> <20030710085338.C28672@infradead.org> <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 10, 2003 at 12:19:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 12:19:59PM +0100, Alan Cox wrote:
> Because you hacked v1 support out of Jan Kara's stuff the quota bits are
> pretty useless to most people because they have v1 format files.

Please take a look at the code before saying something that unqalified. (
or just read the changelog..).

The old quota format is enabled unconditionally, not removed.

