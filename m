Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUG0BKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUG0BKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUG0BEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:04:42 -0400
Received: from waste.org ([209.173.204.2]:27045 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266209AbUG0BEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:04:36 -0400
Date: Mon, 26 Jul 2004 20:03:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@osdl.org, gotrooted@pop.com.br, linux-kernel@vger.kernel.org,
       maillist@jg555.com, ramon.rey@hispalinux.es
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Message-ID: <20040727010345.GU5414@waste.org>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407261737.i6QHbff04878@freya.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:37:41AM -0700, Adam J. Richter wrote:
> 	devfs allows for creation of devices when user level programs
> need them rather than based on "hot plug" or modprobe-related events,
> neither of which do not exist for many devices and do not necessarily
> indicate need for the driver.

One wonders if autofs can be made to do the same.

-- 
Mathematics is the supreme nostalgia of our time.
