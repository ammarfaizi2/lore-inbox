Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVCAUmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVCAUmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCAUjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:39:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:7621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbVCAUi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:38:56 -0500
Date: Tue, 1 Mar 2005 12:38:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-Id: <20050301123828.43798f9e.akpm@osdl.org>
In-Reply-To: <20050301131220.GF1843@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz>
	<20050301020722.6faffb69.akpm@osdl.org>
	<20050301131220.GF1843@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> I can fix disk going yo-yo without switching pm_message_t to struct,
>  but will have to back parts of that later. Do you want patch?

No thanks, I was just pointing it out.  It sounds like you have it under
control.
