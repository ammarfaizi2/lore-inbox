Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTEMEAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTEMEAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:00:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30097 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262610AbTEMEAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:00:13 -0400
Date: Mon, 12 May 2003 20:07:01 -0700 (PDT)
Message-Id: <20030512.200701.42782298.davem@redhat.com>
To: chris@wirex.com
Cc: yoshfuji@linux-ipv6.org, torvalds@transmeta.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix net/rxrpc/proc.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030512200530.I19432@figure1.int.wirex.com>
References: <20030512190036.B20068@figure1.int.wirex.com>
	<20030513.112656.112825273.yoshfuji@linux-ipv6.org>
	<20030512200530.I19432@figure1.int.wirex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wright <chris@wirex.com>
   Date: Mon, 12 May 2003 20:05:30 -0700

   * YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B (yoshfuji@linux-ipv6.org) wrote:
   > 
   > Sorry, it's my mistake.   David, please apply his patch.
   
   Thanks, sorry, I should have Cc:'d you in the first place, my apology.
   Seems like the rxrpc_proc_calls_fops should get an owner as well?  (relative
   to the last patch)
   
Thanks for working all of this out, both changes applied to
my tree.
