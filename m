Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbTEZDH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 23:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTEZDH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 23:07:26 -0400
Received: from rth.ninka.net ([216.101.162.244]:44931 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263912AbTEZDHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 23:07:25 -0400
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
	2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030523193458.B4584@flint.arm.linux.org.uk>
References: <20030523175413.A4584@flint.arm.linux.org.uk>
	 <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
	 <20030523112926.7c864263.akpm@digeo.com>
	 <20030523193458.B4584@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053919227.14018.4.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 20:20:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, it's only by LUCK that I actually read this.

Whoever removed me from the CC: list and still wanted me
to follow up on the conversation needs a good kicking :-)

-- 
David S. Miller <davem@redhat.com>
