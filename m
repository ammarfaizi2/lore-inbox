Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVLMVxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVLMVxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVLMVxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:53:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030238AbVLMVxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:53:02 -0500
Date: Tue, 13 Dec 2005 13:52:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Giving the reins over to Dmitry
Message-Id: <20051213135218.60063c48.akpm@osdl.org>
In-Reply-To: <20051213084111.GA20748@ucw.cz>
References: <20051213084111.GA20748@ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> wrote:
>
>   INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
>  -P:	Vojtech Pavlik
>  -M:	vojtech@suse.cz
>  +P:	Dmitry Torokhov
>  +M:	dtor_core@ameritech.net

Thanks, Vojtech.  Hopefully you'll still have bandwidth to provide us with
guidance on future work.

I guess this means that I should drop http://www.ucw.cz/~vojtech/input/
from the -mm lineup?
