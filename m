Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162219AbWKPC1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162219AbWKPC1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162220AbWKPC1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:27:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16358 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162219AbWKPC1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:27:13 -0500
Date: Wed, 15 Nov 2006 18:27:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Message-ID: <20061116022753.GC6602@sequoia.sous-sol.org>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061115231626.GC31879@stusta.de> <20061115153614.a71f944d.akpm@osdl.org> <455BBF38.5030503@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455BBF38.5030503@vmware.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Well that shouldn't have happened.  Must have been some reject that went 
> unnoticed?  Try this.

Thanks Zach, added to the pv patchqueue as well.
-chris
