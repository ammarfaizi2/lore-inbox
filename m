Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTKSRax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTKSRax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 12:30:53 -0500
Received: from guug.org ([168.234.203.30]:53378 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S263938AbTKSRav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 12:30:51 -0500
Date: Wed, 19 Nov 2003 11:30:45 -0600
To: Thomas Habets <thomas@habets.pp.se>
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: forgotten EXPORT_SYMBOL()s on sparc
Message-ID: <20031119173045.GA8373@guug.org>
References: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 04:38:40AM +0100, Thomas Habets wrote:
> Also, I wonder what the status is for keyboard, mouse and framebuffer is for
> 2.6.0 on sparc. None of them seem to work right now.

framebuffer works perfectly on any sparc i have here, kbd/mouse not working
on sparcs with sunzilog chips.  Hopefully someday i will find the cause or
another person much clever than i would do it.

-solca

