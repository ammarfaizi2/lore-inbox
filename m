Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTJJGtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbTJJGtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:49:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53985 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262543AbTJJGtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:49:46 -0400
Date: Thu, 9 Oct 2003 23:44:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix
Message-Id: <20031009234409.45300c62.davem@redhat.com>
In-Reply-To: <m3ismyvz39.fsf@defiant.pm.waw.pl>
References: <m3ismyvz39.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied.

Please, Krzysztof, linux-kernel and Linus are not the appropriate
place to submit networking (device driver or otherwise) patches.

Therefore, in the future send it to netdev@oss.sgi.com and CC: either
Jeff Garzik or myself, thanks.

I'd also not classify this patch as trivial, it's not like a missing
semicolon or a comment typo, real thought needs to be applied to
analyzing whether your fix were correct or not.
