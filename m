Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUJYEWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUJYEWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUJYEWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:22:02 -0400
Received: from ozlabs.org ([203.10.76.45]:132 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261235AbUJYEWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:22:00 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support
From: Rusty Russell <rusty@rustcorp.com.au>
To: tj@home-tj.org
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023042024.GA3456@home-tj.org>
References: <20041023042024.GA3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:21:57 +1000
Message-Id: <1098678117.8098.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:20 +0900, tj@home-tj.org wrote:
>  Hello,
> 
>  I rewrote the document, debugged and splitted devparam patch.  I'm
> attaching the document in this mail and posting 16 patches
> (dp_01 - dp_16) which are against Linus's bk tree as of today.

Hi TJ,

	Love the idea: thanks for doing this work!  I'm reviewing the patches
themselves now, but I'll mainly concentrate on your moduleparam changes
which I'm not sure are necessary.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

