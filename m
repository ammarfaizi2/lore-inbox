Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUIYJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUIYJwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUIYJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:52:47 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:54623 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269296AbUIYJwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:52:46 -0400
Message-ID: <35fb2e5904092502523e48e6da@mail.gmail.com>
Date: Sat, 25 Sep 2004 10:52:46 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Add wait_event_timeout()
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20040925094445.GK9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040925091359.GA4431@dyn-67.arm.linux.org.uk>
	 <35fb2e590409250242dd353d9@mail.gmail.com>
	 <20040925094445.GK9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 02:44:45 -0700, William Lee Irwin III
<wli@holomorphy.com> wrote:

> Anything interruptible is explicitly tagged as such; the "default",
> sadly enough, is uninterruptible.

Fair enough, if that's the reasoning, then ok (I've never given that
much thought). Oh well...

Jon.
