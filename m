Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUGES2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUGES2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUGES2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:28:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47025 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S266341AbUGES2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:28:52 -0400
Date: Mon, 5 Jul 2004 11:28:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] biarch gcc support for ppc32
Message-ID: <20040705182851.GH2146@smtp.west.cox.net>
References: <20040704112420.GA13748@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704112420.GA13748@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 01:24:20PM +0200, Olaf Hering wrote:

> 
> a native powerpc64-linux gcc can not compile a ppc32 kernel properly.
> This patch fixes it. It was copied from ppc64.
> The change to vmlinux.lds.S fixes this error:

Have all of these changes been tested with a ppc32 compiler as well?
If so, this looks fine.

-- 
Tom Rini
http://gate.crashing.org/~trini/
