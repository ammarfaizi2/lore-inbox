Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267919AbUHEXWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267919AbUHEXWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267924AbUHEXWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:22:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32943 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267919AbUHEXWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:22:52 -0400
Date: Thu, 5 Aug 2004 19:41:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Devel <devel@integra-sc.it>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: patch_kraxel-2.4.26 in kernel 2.4.27
Message-ID: <20040805224109.GB18155@logos.cnet>
References: <20040805161923.4e2e2147.devel@integra-sc.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805161923.4e2e2147.devel@integra-sc.it>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 04:19:23PM +0200, Devel wrote:
> The path patch_kraxel-2.4.26 from http://dl.bytesex.org/patches/ will be included into kernel 2.4.27?
> Thanks by now!

Nope, it wont. A quick look shows it touches a hell lot of stuff.

We should probably try to merge the sane bits? Gerd?
