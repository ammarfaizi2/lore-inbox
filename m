Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTGZSYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGZSYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:24:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:27289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266985AbTGZSYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:24:36 -0400
Date: Sat, 26 Jul 2003 11:39:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: felipe_alfaro@linuxmail.org, kernel@kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O9int for interactivity
Message-Id: <20030726113940.1c71eb47.akpm@osdl.org>
In-Reply-To: <20030726183224.GA789@gmx.de>
References: <200307270306.47363.kernel@kolivas.org>
	<1059243458.575.1.camel@teapot.felipe-alfaro.com>
	<20030726183224.GA789@gmx.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> wrote:
>
> since vanilla runs on HZ=1000 and -mm on HZ=100

No, -mm has been back at 1000 for a couple of weeks now.

But people do need to test with HZ=100 - only eight architectures are using
HZ=1000 at present.

