Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUITASH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUITASH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUITASH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:18:07 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:43679 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265093AbUITASE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:18:04 -0400
Message-ID: <35fb2e590409191718430b0d47@mail.gmail.com>
Date: Mon, 20 Sep 2004 01:18:04 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Max Michaels <mmichaels@rightmedia.com>
Subject: Re: 2.6.8-r1 mem issues
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 16:20:48 -0700, Max Michaels
<mmichaels@rightmedia.com> wrote:

> This is my first post, so please be forgiving of any faux-pas. I am
> having issues with 2.6.8-r1 with memory being eaten by the kernel.

[ I've not yet gone through your .config ]

Could you describe the hardware and any devices that you're using -
looks like you're avoiding modules but it would be helpful to see an
attached dmesg output and lspci -v or similar.

Cheers,

Jon.
