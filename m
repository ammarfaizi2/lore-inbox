Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272319AbRHXUhn>; Fri, 24 Aug 2001 16:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRHXUhe>; Fri, 24 Aug 2001 16:37:34 -0400
Received: from quark.didntduck.org ([216.43.55.190]:38671 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272319AbRHXUhR>; Fri, 24 Aug 2001 16:37:17 -0400
Message-ID: <3B86BAF0.489E92C6@didntduck.org>
Date: Fri, 24 Aug 2001 16:37:04 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ross Vandegrift <ross@willow.seitz.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 broken on 486SX
In-Reply-To: <20010824154233.A10048@willow.seitz.com> <20010824161747.A10618@willow.seitz.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift wrote:
> 
> Ack, that was a horrific problem report.  Here are a few relevant data points I left out:
> 
> Kernels have always been compiled only with 386 optimizations.
>         (tried 486 a few times, no difference)
> Always built including soft float support (not that it matters so early)
> Always built with gcc 2.95.2
> Same kernel binaries work perfectly on a number of other boxen:
>         A 386DX, a number of Pentium 100's, another 486SX, and a K6-2

What was the last known working kernel for this machine?  Have you tried
any -ac kernels?

--

				Brian Gerst
