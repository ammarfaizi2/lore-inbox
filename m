Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVIGJdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVIGJdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVIGJdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:33:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932084AbVIGJdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:33:52 -0400
Date: Wed, 7 Sep 2005 02:31:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: marko.kohtala@gmail.com
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/10] parport: ieee1284 fixes and cleanups
Message-Id: <20050907023159.15352a82.akpm@osdl.org>
In-Reply-To: <20050905183109.284672000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marko.kohtala@gmail.com wrote:
>
> I played with a daisy chain device that is not ieee1284 compliant
> and found buffer overflow and failure to open daisy chain devices.
> While fixing it I found also a number of other problems also affecting
> proper ieee1284 devices.
> 
> This is a collection of the changes I have made. They have been through
> linux-parport mailing list already in January and they have been modified
> according to comments.

umm, OK.  parport patches worry me because nobody seems to understand the
code any more.  We'll see.

You just sent ten patches, all with the same name.  This causes me grief
(See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, section 2a).

I now need to invent names for your patches, and if I later refer to one of
them you won't know which one I'm talking about.  Oh well.

