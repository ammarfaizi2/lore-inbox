Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVCCERl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVCCERl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCCEPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:15:25 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:23019 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261342AbVCCEKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:10:31 -0500
Date: Wed, 2 Mar 2005 20:10:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303041020.GA28642@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:

>  - 2.6.<even>: even at all levels, aim for having had minimally intrusive
>    patches leading up to it (timeframe: a week or two)
>
> with the odd numbers going like:
>
>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up
>    to it (timeframe: a month or two).
>  - 2.<odd>.x: aim for big changes that may destabilize the kernel for
>    several releases (timeframe: a year or two)

[...]

Why not change the "2.6 prefix" to 2.8, 3.0 (or whatever) if/when you
do go to a new naming scheme --- simply to make a clean break between
the new and the old.  Plus it will give the suckdork crowd[1] bigger
numbers to drivel on about.

That said it would be a large numerical leap without and real feature
changes so perhaps that will further add to confusion?

Sigh.



[1] Well, and the CGL and similar people.  "New CGL with improved
    version numbers and fewer calories!"
