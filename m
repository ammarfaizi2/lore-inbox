Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUDEHaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUDEHaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:30:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:43730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbUDEHaE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:30:04 -0400
Date: Mon, 5 Apr 2004 00:29:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "=?ISO-8859-1?B?RnLpZOlyaWM=?= L. W. Meunier" <1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc1
Message-Id: <20040405002954.4a005aa7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404050300470.1706@pervalidus.dyndns.org>
References: <20040404194037.09d67c37.akpm@osdl.org>
	<Pine.LNX.4.58.0404050300470.1706@pervalidus.dyndns.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frédéric L. W. Meunier <1@pervalidus.net> wrote:
>
> This patch doesn't apply to 2.6.5 or 2.6.5-mm1. I get:
> 
>  The next patch would create the file arch/alpha/kernel/osf_sys.c,
>  which already exists!  Assume -R? [n]
> 
>  and so on.
> 
>  2.6.5-mm1 applies cleanly.
> 
>  On Sun, 4 Apr 2004, Andrew Morton wrote:
> 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc1/

oops, damn, thanks.  A broken script.  I've uploaded a fixed version, but
it'll take an hour or so to propagate to the main kernel.org server.  The
1.8MB 2.6.5-mc1.gz is the bad one.  The 240k file is the correct one.

