Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272817AbTG3Jfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTG3Jfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:35:50 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17081
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272817AbTG3Jfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:35:50 -0400
Message-ID: <1059557744.3f279170d5d8e@kolivas.org>
Date: Wed, 30 Jul 2003 19:35:44 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
References: <200307301038.49869.kernel@kolivas.org> <1059554506.569.3.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1059554506.569.3.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:

> On Wed, 2003-07-30 at 02:38, Con Kolivas wrote:
> > Update to the interactivity patches. Not a massive improvement but
> > more smoothing of the corners.
> 
> Wops! Wait a minute! O11.1 is great, but I've had a few XMMS skips that
> I didn't have with O10. They're really difficult to reproduce, but I've
> seen them when moving a window slowly enough to make the underlying
> windows accumulate a lot of redrawing events. Also, although O11.1 feels
> smooth, it's not as smooth as O10 is for me. 

Hmm maybe a little too nice to X at the expense of other stuff. Will address
next time round.

Con
