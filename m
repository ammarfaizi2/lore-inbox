Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283717AbRK3QwJ>; Fri, 30 Nov 2001 11:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283707AbRK3Qv6>; Fri, 30 Nov 2001 11:51:58 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:12804 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283708AbRK3Qvp>; Fri, 30 Nov 2001 11:51:45 -0500
Date: Fri, 30 Nov 2001 09:02:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Simon Turvey <turveysp@ntlworld.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Generating a function call trace
In-Reply-To: <001501c179b1$870db7c0$140ba8c0@mistral>
Message-ID: <Pine.LNX.4.40.0111300900050.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Simon Turvey wrote:

> Is it possible to arbitrarily generate (in a module say) a function call
> trace?

gcc has builtin macros to trace back or ( on x86 ) you can simply chain
through %esp/%ebp



- Davide


