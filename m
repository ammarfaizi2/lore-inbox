Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTA3QAf>; Thu, 30 Jan 2003 11:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTA3QAf>; Thu, 30 Jan 2003 11:00:35 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:61143 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267539AbTA3QAe> convert rfc822-to-8bit; Thu, 30 Jan 2003 11:00:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 15c
Date: Thu, 30 Jan 2003 17:09:09 +0100
User-Agent: KMail/1.4.3
Cc: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org
References: <Pine.LNX.4.50L.0301301131220.27926-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.50L.0301301131220.27926-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301301709.09692.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 January 2003 14:32, Rik van Riel wrote:

Hi Rik,

> rmap 15c:
>   - backport and audit akpm's reliable pte_chain alloc
>     code from 2.5                                         (me)
>   - reintroduce cache size tuning knobs in /proc          (me)
>     | on very, very popular request

GREAT to see this. Already merged for wolk4.0s-pre10 :)

ciao, Marc
