Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967200AbWKYVHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967200AbWKYVHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967209AbWKYVHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:07:55 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50356
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967200AbWKYVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:07:54 -0500
Date: Sat, 25 Nov 2006 13:08:08 -0800 (PST)
Message-Id: <20061125.130808.42776477.davem@davemloft.net>
To: mbligh@google.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, bunk@stusta.de,
       a.p.zijlstra@chello.nl
Subject: Re: Compile failure since 2.6.19-rc6-git5
From: David Miller <davem@davemloft.net>
In-Reply-To: <4568A992.6090404@google.com>
References: <4568A992.6090404@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@google.com>
Date: Sat, 25 Nov 2006 12:37:38 -0800

> -git4 was fine. -git5 and later are broken.
> AFAICS, it was this change: 700f9672c9a61c12334651a94d17ec04620e1976

This has been reported many times to this list, please check
the archives at least casually before reporting build failures
like this, thanks :-)

Andrew will merge a fix.
