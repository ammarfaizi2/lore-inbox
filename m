Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUH0SFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUH0SFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUH0SFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:05:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:10461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266808AbUH0SFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:05:12 -0400
Date: Fri, 27 Aug 2004 11:04:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs/xattr fix
In-Reply-To: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004 Andries.Brouwer@cwi.nl wrote:
> 
> This same bug exists on 2.6.8.1. It is fixed by the patch below.

Fixed (slightly differently) in current -BK. Thanks,

		Linus
