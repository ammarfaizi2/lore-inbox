Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVGZHea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGZHea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGZHe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:34:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbVGZHeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:34:25 -0400
Date: Tue, 26 Jul 2005 00:33:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Cc: ahaning@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
Message-Id: <20050726003322.1bfe17ee.akpm@osdl.org>
In-Reply-To: <42E59E0E.5030306@yahoo.com.br>
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
	<105c793f05072507426fb6d4c9@mail.gmail.com>
	<42E59E0E.5030306@yahoo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
>
> Indeed udev update solved my problem with "preparing system to use udev"
>  hang. It now works like a charm. I had 030 version too.
> 
>  Only the "mounting filesystem" hangs persists :(

Please use ALT-SYSRQ-T to generate an all-task backtrace, then send it to the
list.

