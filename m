Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271035AbTGQHfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTGQHfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:35:32 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:14996
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271035AbTGQHfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:35:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O6.1int
Date: Thu, 17 Jul 2003 17:53:05 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Wade <neroz@ii.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>, Wiktor Wodecki <wodecki@gmx.de>
References: <200307171213.02643.kernel@kolivas.org> <1058427955.754.3.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1058427955.754.3.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171753.05708.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 17:45, Felipe Alfaro Solana wrote:
> On Thu, 2003-07-17 at 04:13, Con Kolivas wrote:
> > The bug in the O6int patch probably wasn't responsible for WIktor's
> > problem actually. It shouldn't manifest for a very long time. Anyway here
> > is the fix and a couple of minor cleanups.
>
> This is even better than plain O6-int. Everything is nearly perfect.
> One thing I dislike a bit is that on my slow PIII 700Mhz, moving a
> medium-sized window over Evolution 1.4.3 main window (displaying my
> INBOX full of messages) makes the window movement a little jumpy
> (Evolution 1.4.3 is well-known to be a serious CPU hogger when
> repainting windows).

Thanks. That one I _do_ know about, and am still thinking about a fair way to 
fix.

Con

