Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWC3H3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWC3H3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWC3H27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:28:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbWC3H26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:28:58 -0500
Date: Wed, 29 Mar 2006 23:28:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] deinline some larger functions from netdevice.h
Message-Id: <20060329232817.317def39.akpm@osdl.org>
In-Reply-To: <200603301021.48925.vda@ilport.com.ua>
References: <200603301021.48925.vda@ilport.com.ua>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
>
> Network folks did non comment on these two patches, let me try
>  submitting them to you instead.

They're both merged (one is in -linus, the other's in -davem).
