Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVCGI7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVCGI7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVCGI7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:59:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:52659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVCGI7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:59:37 -0500
Date: Mon, 7 Mar 2005 00:58:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm1
Message-Id: <20050307005840.4a877d0c.akpm@osdl.org>
In-Reply-To: <1110185497.8407.4.camel@frecb000711.frec.bull.fr>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	<1110185497.8407.4.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> I don't see the connector module [cn.ko] in this new release. Do you
> remove it from your tree definitely?
> 

I was pulling it in via one of Greg's trees.  I don't know why he dropped
it.

Maybe it was my fault ;) I mentioned to Greg the other day that I had some
concerns with the implementation and meant to give it a close review, but I
haven't got onto it yet.

