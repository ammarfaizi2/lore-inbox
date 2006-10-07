Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423069AbWJGCkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423069AbWJGCkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423070AbWJGCkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:40:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423069AbWJGCkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:40:07 -0400
Date: Fri, 6 Oct 2006 19:39:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <p.hardwick@option.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] Char: nozomi, Lindent the code
Message-Id: <20061006193955.207674da.akpm@osdl.org>
In-Reply-To: <54335498213213@wsc.cz>
References: <54335498213213@wsc.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Oct 2006 01:53:58 +0200 (CEST)
Jiri Slaby <jirislaby@gmail.com> wrote:

> [on the top of nozomi-use-tty-wakeup]
> 
> nozomi, Lindent the code
> 
> Use script/Lindent to indent nozomi driver.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit e7e58c9f0d3ce7bed7f8c4b1921da37d65e3ee8f
> tree c0021b53033d27540ed9211a85905ae36ce5668e
> parent b19884f570ea41ff9100cc56962e8d6f435e2337
> author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:47:22 +0200
> committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:47:22 +0200
> 
>  drivers/char/nozomi.c | 2759 ++++++++++++++++++++++++++-----------------------
>  1 files changed, 1446 insertions(+), 1313 deletions(-)

eep, this is all too hard while it's in Greg's tree.

Greg: run Lindent ;)
