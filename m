Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUF1VlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUF1VlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUF1VlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:54167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265238AbUF1VlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:41:04 -0400
Date: Mon, 28 Jun 2004 14:40:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] signal handler defaulting fix ...
Message-Id: <20040628144003.40c151ff.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
>
> 
> Following up from the other thread (2.6.x signal handler bug) this bring 
> 2.4 behaviour in 2.6.
> 

Pity the poor person who tries to understand this change in a year's time. 
Could we have a real changelog please?

