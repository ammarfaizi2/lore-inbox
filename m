Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIEWpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIEWpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUIEWou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:44:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:7372 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267333AbUIEWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:42:50 -0400
Date: Mon, 6 Sep 2004 08:42:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040906084224.A3778599@wobbly.melbourne.sgi.com>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903092721.6e9ec255.akpm@osdl.org> <200409031420.44018.norberto+linux-kernel@bensa.ath.cx> <200409051659.10585.norberto+linux-kernel@bensa.ath.cx> <20040905153238.393c76a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040905153238.393c76a0.akpm@osdl.org>; from akpm@osdl.org on Sun, Sep 05, 2004 at 03:32:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 03:32:38PM -0700, Andrew Morton wrote:
> 
> It seems to be a bug related to O_SYNC writes on XFS.  Apparently an O_SYNC
> write deadlocks immediately.  I'll take a look later, see where the bug was
> introduced.

I have a fix sitting in my inbox from Christoph, I'll test it and
send it along shortly.

thanks.

-- 
Nathan
