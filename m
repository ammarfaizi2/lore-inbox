Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUKCTJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUKCTJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKCTJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:09:20 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:55800 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261817AbUKCTIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:08:18 -0500
Date: Wed, 3 Nov 2004 11:07:57 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041103190757.GA25451@taniwha.stupidest.org>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41891980.6040009@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:46:40PM -0500, Jeff Garzik wrote:

> Wrong.  There are way too many __correct__ drivers to do this at
> present.

i could claim the same is true of MODULE_PARM yet we spew
warning-galore there...

