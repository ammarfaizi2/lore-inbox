Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTIDH3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbTIDH14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:27:56 -0400
Received: from rth.ninka.net ([216.101.162.244]:62408 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264780AbTIDHZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:25:11 -0400
Date: Thu, 4 Sep 2003 00:24:30 -0700
From: "David S. Miller" <davem@redhat.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 - 4 New warnings
Message-Id: <20030904002430.306cfa83.davem@redhat.com>
In-Reply-To: <13539.4.5.59.77.1062658134.squirrel@www.osdl.org>
References: <13539.4.5.59.77.1062658134.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 23:48:54 -0700 (PDT)
John Cherry <cherry@osdl.org> wrote:

> drivers/net/wan/cosa.c:516: warning: implicit declaration of function `sti'
> drivers/net/wan/cosa.c:661: warning: `MOD_INC_USE_COUNT' is deprecated
> (declared at include/linux/module.h:482)

There is no way these warnings were added in the past
24 hours, they've been there nearly the entire 2.5.x
series.
