Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUH2Xq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUH2Xq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUH2Xq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:46:57 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:1945 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268410AbUH2XqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:46:12 -0400
Date: Sun, 29 Aug 2004 16:45:28 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: jgarzik@pobox.com, pp@ee.oulu.fi, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
Message-Id: <20040829164528.220424e5.davem@davemloft.net>
In-Reply-To: <200408292304.25447.jolt@tuxbox.org>
References: <200408292218.00756.jolt@tuxbox.org>
	<200408292233.03879.jolt@tuxbox.org>
	<41324158.4020709@pobox.com>
	<200408292304.25447.jolt@tuxbox.org>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 23:04:24 +0200
Florian Schirmer <jolt@tuxbox.org> wrote:

> Sorry for that. KMail seems to mangle the message as soon as you sign
> it. Please find the non broken versions attached to this mail.

I think Florian's changes are fine.

BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
please :-)  3/4 of this driver have been rewritten since I last
touched it, heh.
