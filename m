Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUD2PuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUD2PuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUD2PuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:50:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19871 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261300AbUD2PuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:50:09 -0400
Date: Thu, 29 Apr 2004 08:50:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com,
       mpm@selenic.com, zwane@linuxpower.ca
Subject: Re: [PATCH] Kconfig.debug family
Message-ID: <20040429155007.GU3731@smtp.west.cox.net>
References: <20040421205140.445ae864.rddunlap@osdl.org> <20040426164252.GA19246@smtp.west.cox.net> <20040429083820.6457fa84.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429083820.6457fa84.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 08:38:20AM -0700, Randy.Dunlap wrote:

> On Mon, 26 Apr 2004 09:42:52 -0700 Tom Rini wrote:
> 
> | On Wed, Apr 21, 2004 at 08:51:40PM -0700, Randy.Dunlap wrote:
> | 
> | > Localizes kernel debug options in lib/Kconfig.debug.
> | > Puts arch-specific debug options in $ARCH/Kconfig.debug.
> | [snip]
> | >  arch/ppc/Kconfig             |  124 -------------------------
> | >  arch/ppc/Kconfig.debug       |   71 ++++++++++++++
> | 
> | OCP shouldn't be moved into Kconfig.debug, it's just in an odd location
> | right now.
> 
> 
> Thanks.  I moved it to under Processor options, before Platform
> options.  Is that OK?

Yup, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
