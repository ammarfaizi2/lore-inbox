Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVARQuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVARQuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVARQuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:50:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261347AbVARQuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:50:06 -0500
Date: Tue, 18 Jan 2005 11:49:51 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Michal Ludvig <michal@logix.cz>, Andrew Morton <akpm@osdl.org>,
       <cryptoapi@lists.logix.cz>, "David S. Miller" <davem@davemloft.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
 at a time
In-Reply-To: <1105793137.16065.17.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0501181147490.24891-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005, Fruhwirth Clemens wrote:

> However, developing two different APIs isn't particular efficient. I
> know, at the moment there isn't much choice, as J.Morris hasn't commited
> to acrypto in anyway.

There is also the OCF port (OpenBSD crypto framework) to consider, if 
permission to dual license from the original authors can be obtained.


- James
-- 
James Morris
<jmorris@redhat.com>


