Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUGKF2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUGKF2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUGKF2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:28:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:51949 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266502AbUGKF2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:28:43 -0400
Date: Sat, 10 Jul 2004 22:27:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: karim@opersys.com, akropel1@rochester.rr.com, linux-kernel@vger.kernel.org,
       tim.bird@am.sony.com, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-Id: <20040710222702.3718842e.akpm@osdl.org>
In-Reply-To: <200407110019.14558.dtor_core@ameritech.net>
References: <40EEF10F.1030404@am.sony.com>
	<200407102351.05059.dtor_core@ameritech.net>
	<40F0C8E8.2060908@opersys.com>
	<200407110019.14558.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> I am no longer question presence of the code in the kernel, I just don't like
>  the message...

yup, we shouldn't have the friendly message.
