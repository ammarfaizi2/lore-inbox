Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSAKUEu>; Fri, 11 Jan 2002 15:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290082AbSAKUEk>; Fri, 11 Jan 2002 15:04:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:2319 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290086AbSAKUE1>;
	Fri, 11 Jan 2002 15:04:27 -0500
Subject: Re: [PATCH] Small optimization for UP in sched and prefetch
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Rainer Keller <Keller@hlrs.de>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201112101290.31366-100000@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.33.0201112101290.31366-100000@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 11 Jan 2002 15:07:06 -0500
Message-Id: <1010779627.815.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 15:02, Dave Jones wrote:

> It's handled a few lines further down in a CONFIG_X86_USE_3DNOW
> which means that CyrixIII's can also use them too.

Ah, my mistake.  I should of read the source and not just the patch.

	Robert Love

