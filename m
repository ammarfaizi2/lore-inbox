Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUDQAee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbUDQAee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:34:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:3491 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263642AbUDQAed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:34:33 -0400
Date: Fri, 16 Apr 2004 17:31:29 -0700
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CPQPHP] Fix build without hotplug
Message-ID: <20040417003129.GA11560@kroah.com>
References: <20040416221634.GA15721@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416221634.GA15721@gondor.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 08:16:34AM +1000, Herbert Xu wrote:
> Hi:
> 
> This patch makes cpqphp build without procfs.

Why would you want to do that?

thanks,

greg k-h
