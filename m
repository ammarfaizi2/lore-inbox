Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758444AbWK0RRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444AbWK0RRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758449AbWK0RRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:17:55 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:12809 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1758444AbWK0RRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:17:54 -0500
Subject: Re: [patch] Re: 2.6.19-rc6-mm1 --
	sched-improve-migration-accuracy.patch slows boot
From: Don Mullis <dwm@meer.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164624611.5892.27.camel@Homer.simpson.net>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
	 <1164522263.5808.12.camel@Homer.simpson.net>
	 <1164591509.2894.76.camel@localhost.localdomain>
	 <1164624611.5892.27.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 09:17:32 -0800
Message-Id: <1164647852.2894.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The below should fix it, can you confirm?

Brings boot speed back to normal.

Acked-by: Don Mullis <dwm@meer.net>


