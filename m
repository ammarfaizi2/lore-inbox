Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbUJYIZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUJYIZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJYITS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:19:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:14983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261703AbUJYHiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:38:18 -0400
Date: Mon, 25 Oct 2004 00:36:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com, torvalds@osdl.org
Subject: Re: [PATCH] reduce top(1) CPU usage by an order of magnitude
Message-Id: <20041025003600.2f03c1fd.akpm@osdl.org>
In-Reply-To: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> Patch is not mine, Paulo Marques <pmarques@grupopie.com>
>  wrote it.
> 
>  I tested in on 2.6.9-rc2. top(1) CPU usage went from ~40% to ~4%
>  (yes, test box is a rather old piece of junk).
> 
>  The patch applies cleanly to 2.6.9.

umm, this patch has been in -mm for six weeks, and in Linus's kernel for
one week.
