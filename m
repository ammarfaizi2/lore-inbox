Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUKHRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUKHRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUKHROS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:14:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21151 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261938AbUKHQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:41:40 -0500
Date: Mon, 8 Nov 2004 09:41:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] Additional kgdb hooks
Message-ID: <20041108164139.GA21042@smtp.west.cox.net>
References: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:32:41PM +0000, dhowells@redhat.com wrote:

> The attached patch adds a couple of extra hooks by which kgdb or an equivalent
> gdbstub can catch bad_page() and panic() invocations.

What stub are you using that doesn't catch these?

-- 
Tom Rini
http://gate.crashing.org/~trini/
