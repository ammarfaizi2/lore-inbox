Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSFJTIO>; Mon, 10 Jun 2002 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315794AbSFJTIN>; Mon, 10 Jun 2002 15:08:13 -0400
Received: from [209.237.59.50] ([209.237.59.50]:44083 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315785AbSFJTIM>; Mon, 10 Jun 2002 15:08:12 -0400
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 12:08:08 -0700
Message-ID: <52lm9n7y07.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thomas" == Thomas Mirlacher <Thomas> writes:

    Thomas> and what about C99 style named initializers for structs?

    Thomas> struct blah = { .open = driver_open };

C99 named initializers were already supported at least as early as gcc
2.95.2

Best,
  Roland


