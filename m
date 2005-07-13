Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVGMUOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVGMUOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVGMUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:14:18 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:54901 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262748AbVGMUN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:13:56 -0400
Date: Wed, 13 Jul 2005 22:01:51 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow cscope to index multiple architectures
Message-ID: <20050713220151.GE16374@mars.ravnborg.org>
References: <1119522355.2995.23.camel@icampbell-debian> <20050713214337.GC16374@mars.ravnborg.org> <1121285416.5337.3.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121285416.5337.3.camel@azathoth.hellion.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The patch has: 
> 
> +ALLSOURCE_ARCHS := $(ARCH)
> 
> won't that do it? I thought $(ARCH) would be i386 so ALLSOURCE_ARCHS
> will be too unless you override it.

I overlooked that part.
Applied.

	Sam
