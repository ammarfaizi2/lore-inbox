Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUCFQe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 11:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUCFQe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 11:34:59 -0500
Received: from zork.zork.net ([64.81.246.102]:666 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261687AbUCFQe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 11:34:57 -0500
To: Karl Dahlke <eklhad@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dhclient, 2.6.0, config_filter
References: <S261684AbUCFQUC/20040306162003Z+795@vger.kernel.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Karl Dahlke <eklhad@comcast.net>,
 linux-kernel@vger.kernel.org
Date: Sat, 06 Mar 2004 16:34:55 +0000
In-Reply-To: <S261684AbUCFQUC/20040306162003Z+795@vger.kernel.org> (Karl
 Dahlke's message of "Sat, 06 Mar 2004 11:21:54")
Message-ID: <6ubrnalys0.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Dahlke <eklhad@comcast.net> writes:

> Perhaps this has been asked many times here; I don't usually read this list,
> but I can't find an answer anywhere else.
>
> I upgraded to kernel 2.6.0, then 2.6.3,
> and dhclient won't work, because I didn't say yes to CONFIG_FILTER.
> But aha, CONFIG_FILTER is gone.  Nowhere to be found.
> The config options before and after this one are still there,
> but CONFIG_FILTER is not in Kconfig at all.
> What should I do?

To my knowledge, the functionality that CONFIG_FILTER used to control
is now permanently enabled.

What error messages(s) does dhclient print?

