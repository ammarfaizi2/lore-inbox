Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTJ0Jrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTJ0Jrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:47:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50622 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261342AbTJ0JrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:47:04 -0500
Date: Mon, 27 Oct 2003 01:40:32 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.6.0-test9
Message-Id: <20031027014032.4908019f.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310261752160.3157-100000@home.osdl.org>
References: <UTC200310270148.h9R1mqO06057.aeb@smtp.cwi.nl>
	<Pine.LNX.4.44.0310261752160.3157-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to just revert the changeset in the networking
fixes I send to Linus today.

If we resolve this some other way, that's fine and the
original change is in the revision history for people
to refer to.
