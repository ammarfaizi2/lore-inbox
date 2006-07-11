Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWGKXzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWGKXzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWGKXzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:55:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWGKXzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:55:45 -0400
Date: Tue, 11 Jul 2006 16:55:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, efault@gmx.de
Subject: Re: [patch] i386: handle_BUG(): don't print garbage if debug info
 unavailable
In-Reply-To: <20060711164208.323dada1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607111655030.5623@g5.osdl.org>
References: <200607101034_MC3-1-C497-51F7@compuserve.com>
 <20060711012755.59965932.akpm@osdl.org> <44B382DD.5070202@yahoo.com.au>
 <Pine.LNX.4.64.0607110959160.5623@g5.osdl.org> <20060711164208.323dada1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, Andrew Morton wrote:
> 
> This?

Looks correct to me.

		Linus
