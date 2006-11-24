Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757565AbWKXB4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbWKXB4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbWKXB4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:56:25 -0500
Received: from localhost.localdomain ([127.0.0.1]:27803 "EHLO localhost")
	by vger.kernel.org with ESMTP id S1757510AbWKXB4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:56:24 -0500
Date: Thu, 23 Nov 2006 20:56:24 -0500 (EST)
Message-Id: <20061123.205624.74734820.davem@davemloft.net>
To: misterpib@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: re-fix of doc-comment in sock.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061118082727.GA1250@pib>
References: <20061118082727.GA1250@pib>
X-Mailer: Mew version 5.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Bonser <misterpib@gmail.com>
Date: Sat, 18 Nov 2006 00:27:27 -0800

> From: Paul Bonser <misterpib@gmail.com>
> 
> Restoring old, correct comment for sk_filter_release, moving it to where it should actually be, and changing new comment into proper comment for sk_filter_rcu_free, where it actually makes sense.
> 
> The original fix submitted for this on Oct 23 mistakenly documented the wrong function.
> 
> Signed-off-by: Paul Bonser <misterpib@gmail.com>

Applied, thanks.
