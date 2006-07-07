Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGGWgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGGWgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGGWgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:36:04 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:23010 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932363AbWGGWgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:36:03 -0400
Date: Sat, 8 Jul 2006 00:35:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: wookey@debian.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060707223536.GA28811@mars.ravnborg.org>
References: <20060707173458.GB1605@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707173458.GB1605@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 11:34:58AM -0600, Matthew Wilcox wrote:
> Kconfig doesn't currently handle config files with DOS line endings.
> While these are, of course, an abomination, etc, etc, it can be handy
> to not have to convert them first.  It's also a tiny patch and even adds
> support for lines ending in just \r or even \n\r.

Applied after updating path to -rc1.

	Sam
