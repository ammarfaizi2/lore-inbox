Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272653AbTHEL3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272655AbTHEL3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:29:47 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:36510
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272653AbTHEL3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:29:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 21:34:55 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052112.12553.kernel@kolivas.org> <3F2F93A7.4070808@cyberone.com.au>
In-Reply-To: <3F2F93A7.4070808@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052134.55542.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 21:23, Nick Piggin wrote:
> I know you haven't been just tweaking numbers ;) But in the case of the
> patch that provides different behaviour depending on whether a sleep is
> interruptible or not really smelt of papering over symptoms. Now it might
> be that nothing better can be done without move invasive changes, but I
> just thought I'd voice my concerns.

Indeed and the more discussion on the topic the better we can nut it out. 
Especially on lkml where having the last word is important ;-D

> Oh, and remember that your desktop load is devoid of make -j big compiles,
> so that is not a requisite for good interactivity.

Thank goodness ;-). It's an easy way to reproduce a problem on a grander 
scale.

Con

