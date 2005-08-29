Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVH2S6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVH2S6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVH2S6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:58:37 -0400
Received: from mail.linicks.net ([217.204.244.146]:44551 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751306AbVH2S6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:58:37 -0400
From: Nick Warne <nick@linicks.net>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: 2.6.13 new option timer frequency
Date: Mon, 29 Aug 2005 19:58:24 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050829184818.3305.qmail@lwn.net>
In-Reply-To: <20050829184818.3305.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508291958.24125.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 19:48, Jonathan Corbet wrote:
> > I built and installed 2.6.13 today, and oldconfig revealed the new option
> > for timer frequency.
> >
> > I searched the LKML on this, but all I found is the technical stuff - not
> > really any layman solutions.
>
> I wrote a bit about the timer frequency option a few weeks ago:
>
> 	http://lwn.net/Articles/145973/

OK, thanks everybody for replies.

Jon, that is a near perfect article - I understand it all now.

I haven't noticed anything different under 250HZ yet..., if anything machine 
seems smoother.  Lower electricity bills will be handy as well ;-)

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
