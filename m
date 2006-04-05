Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWDECrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWDECrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWDECrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:47:52 -0400
Received: from waste.org ([64.81.244.121]:3030 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751079AbWDECrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:47:52 -0400
Date: Tue, 4 Apr 2006 21:47:46 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] netconsole: set .name in struct console
Message-ID: <20060405024746.GH15445@waste.org>
References: <20060404185420.fbf128c8.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404185420.fbf128c8.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 06:54:20PM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Set .name in netconsole's struct console to identify the
> struct's owner.

Too bad we don't have enough room for the whome name.
 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
