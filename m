Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTHSTeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTHSTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:25:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45709 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261305AbTHSTXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:23:54 -0400
Date: Tue, 19 Aug 2003 12:16:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
Cc: alan@lxorguk.ukuu.org.uk, skraw@ithnet.com, willy@w.ods.org,
       richard@aspectgroup.co.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819121603.1cc70937.davem@redhat.com>
In-Reply-To: <091f01c36686$dade2bf0$c801a8c0@llewella>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
	<20030819085717.56046afd.davem@redhat.com>
	<20030819185219.116fd259.skraw@ithnet.com>
	<1061319864.30565.52.camel@dhcp23.swansea.linux.org.uk>
	<20030819120131.1999b1ec.davem@redhat.com>
	<091f01c36686$dade2bf0$c801a8c0@llewella>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 21:19:44 +0200
"Bas Bloemsaat" <bloemsaa@xs4all.nl> wrote:

> > Indeed, would people stop quoting from RFC 985 and
> > RFC 826.
> 
> RFC 826 is referenced from 1009 as describing ARP. So in effect it does
> define a standard.

The RFC 826 document clearly says, at the top, "This is not
an Internet Standard"

It does not define a standard.  And given that it really isn't
surprising it has errors in it as we've clearly shown in these
threads.  The authors of said document didn't scuritinize it
to the level it would need to be in order to truly be a standards
document people must follow to have a conformant implementation.

