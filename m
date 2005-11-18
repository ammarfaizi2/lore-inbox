Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVKREHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVKREHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVKREHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:07:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932482AbVKREHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:07:46 -0500
Date: Thu, 17 Nov 2005 20:03:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: davej@redhat.com, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
Message-Id: <20051117200354.6acb3599.akpm@osdl.org>
In-Reply-To: <20051117.194239.37311109.davem@davemloft.net>
References: <20051118024433.GN11494@stusta.de>
	<20051117185529.31d33192.akpm@osdl.org>
	<20051118031751.GA2773@redhat.com>
	<20051117.194239.37311109.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> The deprecated warnings are so easy to filter out, so I don't think
>  noise is a good argument.  I see them all the time too.

That works for you and me.  But how to train all those people who write
warny patches?

