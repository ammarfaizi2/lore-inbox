Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUFJQ10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUFJQ10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUFJQ10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:27:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:61150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261685AbUFJQ1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:27:12 -0400
Date: Thu, 10 Jun 2004 09:26:06 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Whitespace fixes
Message-ID: <20040610162606.GA32258@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net> <200406100145.01599.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100145.01599.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:44:59AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1768, 2004-06-10 00:07:32-05:00, dtor_core@ameritech.net
>   Whitespace and formatting changes (a,b,c -> a, b, c) in drivers/base
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Ok, I've applied the majority of this patch.  But the bus.c and class.c
files are different in my tree than in Linus's right now, so I'll apply
those sections by hand and fix up the rejects in a separate changeset.

thanks again.

greg k-h
