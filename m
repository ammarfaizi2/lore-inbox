Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVC3Wbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVC3Wbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVC3Wbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:31:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59809 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262462AbVC3Wbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:31:31 -0500
Date: Wed, 30 Mar 2005 14:27:13 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davidsen@tmr.com, herbert@gondor.apana.org.au, johnpol@2ka.mipt.ru,
       davidm@snapgear.com, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       akpm@osdl.org, jmorris@redhat.com
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
Message-Id: <20050330142713.05e0796d.pj@engr.sgi.com>
In-Reply-To: <424B1ED0.3010705@pobox.com>
References: <4249D06F.30802@tmr.com>
	<4249D06F.30802@tmr.com>
	<4249DAD4.9020602@pobox.com>
	<424B18A1.2060502@tmr.com>
	<424B1ED0.3010705@pobox.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:
> Or all 1's (more likely), or all 0x55's, or...

Stray thought - to follow up stray thought:

    Hmmm ... run some numbers through a good compression program,
    and complain if they compress much.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
