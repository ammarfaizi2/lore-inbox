Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUGRWYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUGRWYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUGRWYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:24:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:11909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264538AbUGRWYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:24:36 -0400
Date: Sun, 18 Jul 2004 18:24:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-Id: <20040718182402.6711e4e8.akpm@osdl.org>
In-Reply-To: <20040718220408.GA31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
	<20040718220408.GA31958@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Unfortuanetly I can't just pull (I'm not allowed to use bitkeeper). I
> could roll them into one big patch and then push them to akpm on my
> own, but that would loose history :-(.

I'll just add Pat's BK URL to my list-of-bk-trees-to-add-to-mm-kernels. 
That brings it up to 25 external trees, believe it or not.

Pat, that means that anything which you commit gets autosucked into -mm, so
if there is a different URL which I should be using, please let me know.

