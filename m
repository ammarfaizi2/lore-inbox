Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTJEOQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTJEOQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:16:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263117AbTJEOQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:16:40 -0400
Date: Sun, 5 Oct 2003 07:11:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo.tosatti@cyclades.com, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: iproute2 not compiling anymore
Message-Id: <20031005071152.49c35297.davem@redhat.com>
In-Reply-To: <20031005130044.GA8861@pcw.home.local>
References: <Pine.LNX.4.44.0310050940160.27815-100000@logos.cnet>
	<20031005130044.GA8861@pcw.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Oct 2003 15:00:44 +0200
Willy TARREAU <willy@w.ods.org> wrote:

> /usr/src/linux/include/linux/in.h:147: field `gsr_group' has incomplete type

I'll happily fix this, thanks for reporting this.

Can you please in the future report such things on the networking
development list netdev@oss.sgi.com?  Thanks.
