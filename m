Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWHFO6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWHFO6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHFO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:58:07 -0400
Received: from colin.muc.de ([193.149.48.1]:46347 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751204AbWHFO6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:58:06 -0400
Date: 6 Aug 2006 16:58:01 +0200
Date: Sun, 6 Aug 2006 16:58:01 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060806145801.GA4494@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <20060806023824.GA41762@muc.de> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <1154836321.29151.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154836321.29151.50.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I feel fairly strongly about this, but I'll drop the x86_64 changes.

I would prefer if you leave them alone in i386 too.

-andi
