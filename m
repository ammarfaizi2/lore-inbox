Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWIZVfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWIZVfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWIZVfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:35:46 -0400
Received: from khc.piap.pl ([195.187.100.11]:27273 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964828AbWIZVfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:35:45 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       PC300 Maintainer <pc300@cyclades.com>
Subject: Re: Generic HDLC update
References: <m3odt21hs5.fsf@defiant.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 23:35:44 +0200
In-Reply-To: <m3odt21hs5.fsf@defiant.localdomain> (Krzysztof Halasa's message of "Tue, 26 Sep 2006 22:42:34 +0200")
Message-ID: <m3ac4m1fbj.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

The first patch renames drivers/net/wan/hdlc_generic.c file to hdlc.c.
It has been generated with git-diff* -M. Please let me know if you
need a "normal" patch.
-- 
Krzysztof Halasa
