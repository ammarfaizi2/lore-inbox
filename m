Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTEZFrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEZFrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:47:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264277AbTEZFrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:47:23 -0400
Date: Sun, 25 May 2003 22:59:48 -0700 (PDT)
Message-Id: <20030525.225948.118605382.davem@redhat.com>
To: hch@infradead.org
Cc: solt@dns.toxicfilms.tv, davem@caip.rutgers.edu, Eric.Schenk@dna.lth.se,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make icmp.c be more verbose on broadcast icmp errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030526065602.A19100@infradead.org>
References: <Pine.LNX.4.51.0305231222450.8169@dns.toxicfilms.tv>
	<1053922444.14018.7.camel@rth.ninka.net>
	<20030526065602.A19100@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Mon, 26 May 2003 06:56:02 +0100

   net/README:
 ...   
   probably this file should be removed completly - it's horribly outdated
   and we have MAINTAINERS for that purpose..

Oh yes, let's kill that thing :-)
