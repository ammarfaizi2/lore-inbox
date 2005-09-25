Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVIYWAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVIYWAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVIYWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:00:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbVIYWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:00:23 -0400
Date: Sun, 25 Sep 2005 14:59:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] swsusp: fix some obscure bugs
Message-Id: <20050925145935.057e067f.akpm@osdl.org>
In-Reply-To: <20050925214708.GA2775@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl>
	<20050925214708.GA2775@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > The following series of patches fixes some obscure bugs in swsusp.
> 
>  Andrew, could you apply parts #1 and #2? First is data-corruption in
>  error path (nasty!), second is simple bugfix.

Sure.
