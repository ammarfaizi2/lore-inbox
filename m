Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUATF1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUATF1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:27:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:150 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265061AbUATF1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:27:22 -0500
Date: Mon, 19 Jan 2004 21:19:21 -0800
From: "David S. Miller" <davem@redhat.com>
To: Michal Ludvig <michal@logix.cz>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIT tunnels over IPsec
Message-Id: <20040119211921.2b213ee1.davem@redhat.com>
In-Reply-To: <40082F88.9030705@logix.cz>
References: <40082F88.9030705@logix.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004 19:38:00 +0100
Michal Ludvig <michal@logix.cz> wrote:

> The attached patch fixes IPv6-in-IPv4 (SIT) tunnel over IPsec. Without 
> it the SIT packets originated from the same host as the IPsec endpoint 
> is leave the interface unencrypted and of course the tunnel doesn't 
> work. The patch fixes it. Tested.
> 
> Please apply.

Applied, thanks Michal.
