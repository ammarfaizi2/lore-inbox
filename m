Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTHSWTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTHSWT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:19:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55951 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261292AbTHSWT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:19:27 -0400
Date: Tue, 19 Aug 2003 15:11:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: alan@lxorguk.ukuu.org.uk, skraw@ithnet.com, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819151137.3d6e78f2.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB60@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB60@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 23:12:38 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> 	I'm certain that Cisco (for example) won't change their ways.

I don't believe this.

In cases where we've been able to show their devices to
be faulty, they've fixed their kit.  Go check out what
happened wrt. the ECN issues their firewall products had.
