Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbTLWDX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTLWDX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:23:56 -0500
Received: from dp.samba.org ([66.70.73.150]:16262 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264936AbTLWDXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:23:53 -0500
Date: Tue, 23 Dec 2003 14:21:12 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 modules don't link properly
Message-Id: <20031223142112.2923f174.rusty@rustcorp.com.au>
In-Reply-To: <bs7u1f$8ns$1@gatekeeper.tmr.com>
References: <bs7u1f$8ns$1@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Dec 2003 23:17:03 GMT
davidsen@tmr.com (bill davidsen) wrote:

> I tried building 2.6.0-final on a new whitebox-3.0-final install, and
> the modules_install produced thousands of unresolved symbols. This built
> on another machine I've been running and updating since the 2.5.3x days,
> so there might be something I've missed, but I don't quite see what it
> would be.

IDE as a module?  Some configs seem to be broken.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
