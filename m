Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752124AbWIXGdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbWIXGdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 02:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWIXGdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 02:33:10 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:17282 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1752124AbWIXGdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 02:33:09 -0400
Date: Sun, 24 Sep 2006 08:33:07 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060924063307.GA13487@xi.wantstofly.org>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <20060922112649.2b98cc2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922112649.2b98cc2d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 11:26:49AM -0700, Andrew Morton wrote:

> <I maintain that it is in the interests of obscure-arch maintainers
> to help others build cross-compilers for their arch..>

As I regularly test with different gcc versions and encourage others
to do the same, I've had a set available for a while at:

	http://www.wantstofly.org/~buytenh/kernel/arm-cross/

(Generated with crosstool 0.42, see http://kegel.com/crosstool)  Any
suggestions for making them easier to find for folks?


cheers,
Lennert
