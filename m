Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUJSOtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUJSOtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUJSOtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:49:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:55192 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269433AbUJSOtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:49:08 -0400
Subject: Re: [PATCH] Re: Weird... 2.6.9 kills FC2 gcc
From: Mark Haverkamp <markh@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41748A9D.2080306@pobox.com>
References: <4174697B.90306@pobox.com> <1098150587.1384.0.camel@peabody>
	 <41747A28.2000101@pobox.com>  <41748A9D.2080306@pobox.com>
Content-Type: text/plain
Date: Tue, 19 Oct 2004 07:48:58 -0700
Message-Id: <1098197339.1278.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 23:31 -0400, Jeff Garzik wrote:
> More data points:
> 
> No problems at all on x86-64.
> 
> No ICE on 32-bit x86 gcc 3.4.2, with 2.6.9 release kernel.
> 
> So this ICE appears to be a bug specific to 3.3.x or perhaps Fedora.
> 
> 	Jeff
> 

I tried building this on FC3 with a 3.4.2 gcc and it compiles OK.

Mark.


-- 
Mark Haverkamp <markh@osdl.org>

