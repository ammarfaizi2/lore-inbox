Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWEOHkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWEOHkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWEOHkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:40:22 -0400
Received: from colin.muc.de ([193.149.48.1]:11792 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751053AbWEOHkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:40:21 -0400
Date: 15 May 2006 09:40:19 +0200
Date: Mon, 15 May 2006 09:40:19 +0200
From: Andi Kleen <ak@muc.de>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Segfault on the i386 enter instruction
Message-ID: <20060515074019.GA33242@muc.de>
References: <44676F42.7080907@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44676F42.7080907@aknet.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aren't the rlimit and the other checks of acct_stack_growth()
> not enough, or am I missing something obvious?

Traditionally Linux doesn't have a stack ulimit.

-Andi
