Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUAYWF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUAYWF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:05:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265310AbUAYWEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:04:48 -0500
Date: Sun, 25 Jan 2004 13:55:47 -0800 (PST)
Message-Id: <20040125.135547.99459090.davem@redhat.com>
To: kaber@trash.net
Cc: sebek64@post.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <401425B6.4050701@trash.net>
References: <20040125152419.GA3208@penguin.localdomain>
	<20040125.112542.10303353.davem@redhat.com>
	<401425B6.4050701@trash.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick McHardy <kaber@trash.net>
   Date: Sun, 25 Jan 2004 21:23:18 +0100

   David S. Miller wrote:
   > Patrick, do you mind if I merge this 2.6.x port into my tree?
   
   Please don't. The imq device is buggy, 
 ...
   Some users that depend on the functionality
   are working on a better implementation, I'd suggest to wait
   until then.

Ok.
