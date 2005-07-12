Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVGLDMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVGLDMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVGLDMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:12:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbVGLDMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:12:02 -0400
Date: Mon, 11 Jul 2005 20:11:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hal Rosenstock <halr@voltaire.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: [PATCH 0/29v2] InfiniBand core update
Message-Id: <20050711201117.72539977.akpm@osdl.org>
In-Reply-To: <1121136330.4389.5093.camel@hal.voltaire.com>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	<20050711170548.31605e23.akpm@osdl.org>
	<1121136330.4389.5093.camel@hal.voltaire.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Rosenstock <halr@voltaire.com> wrote:
>
> > I'll tentatively consider this material to be not-for-2.6.13?
> 
>  Presuming that "this material" refers to the patch to add the kernel CM
>  implementation, if kernel CM does not make 2.6.13, then user CM should
>  not either as it is dependent on it.

Well I was asking.  Do you guys think that this material is appropriate to
and safe enough for 2.6.13?

What are "user CM" and "kernel CM"?
