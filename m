Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbTHSTNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbTHSTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:10:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23693 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261263AbTHSTJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:09:07 -0400
Date: Tue, 19 Aug 2003 12:01:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, richard@aspectgroup.co.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819120131.1999b1ec.davem@redhat.com>
In-Reply-To: <1061319864.30565.52.camel@dhcp23.swansea.linux.org.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
	<20030819185219.116fd259.skraw@ithnet.com>
	<1061319864.30565.52.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 20:04:25 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-08-19 at 17:52, Stephan von Krawczynski wrote:
> > <quote RFC-985>
> 
> Effectively Obsolete.

Indeed, would people stop quoting from RFC 985 and
RFC 826.
