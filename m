Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTF1WDz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTF1WDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:03:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:21377 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265422AbTF1WDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:03:54 -0400
Subject: Re: Broadcom Gigabit + Linux 2.4.20 - Error with polling.
From: "David S. Miller" <davem@redhat.com>
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, ap@solarrain.com
In-Reply-To: <Pine.LNX.4.56.0306280640290.13092@p500>
References: <Pine.LNX.4.56.0306280640290.13092@p500>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056838686.17263.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 28 Jun 2003 15:18:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 03:44, war wrote:
> tg3: eth0: Error, poll already scheduled

Fixed in 2.4.21

