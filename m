Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTELHfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTELHfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:35:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20106 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261971AbTELHfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:35:00 -0400
Date: Sun, 11 May 2003 23:42:03 -0700 (PDT)
Message-Id: <20030511.234203.57448687.davem@redhat.com>
To: tomlins@cam.org
Cc: akpm@digeo.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, laforge@netfilter.org
Subject: Re: Slab corruption mm3 + davem fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305120344.50347.tomlins@cam.org>
References: <20030511151506.172eee58.akpm@digeo.com>
	<1052692449.4471.4.camel@rth.ninka.net>
	<200305120344.50347.tomlins@cam.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ed Tomlinson <tomlins@cam.org>
   Date: Mon, 12 May 2003 03:44:50 -0400

   On May 11, 2003 06:34 pm, David S. Miller wrote:
   > > > Yeah, more bugs in the NAT netfilter changes.  Debugging this one
   > > > patch is becomming a full time job :-(
   
   But you do it well...  Looks like this fixes the slab problems here with
   69-bk from Sunday am.
   
Thank you for testing.
