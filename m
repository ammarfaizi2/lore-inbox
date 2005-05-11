Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVEKXrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVEKXrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVEKXrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:47:25 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:44440 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261448AbVEKXrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:47:22 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace  cleanup)
To: Jesper Juhl <juhl-lkml@dif.dk>, "David S.Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 12 May 2005 01:47:28 +0200
References: <42Mbg-Tq-25@gated-at.bofh.it> <42MXA-1zI-3@gated-at.bofh.it> <42MXA-1zI-1@gated-at.bofh.it> <42Nh3-1M8-17@gated-at.bofh.it> <42Nh3-1M8-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:

> If Andrew agrees, then I'll commit to doing this cleanup;

> - (to a limited degree) no trailing whitespace

I just ran a script over -rc4 to remove trailing ws. The result is
about 22 MB in 429 patches (iterated over ./*/*).

How hard can I patch you before you start patching me?

Which addresses am I supposed to send it to? I don't want to break the
record for the most annoying patch series in lkml.
-- 
If at first you don't succeed, call it version 1.0 

