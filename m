Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRFFUlm>; Wed, 6 Jun 2001 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbRFFUlc>; Wed, 6 Jun 2001 16:41:32 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21267 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261268AbRFFUla>; Wed, 6 Jun 2001 16:41:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman),
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Break 2.4 VM in five easy steps
Date: Wed, 6 Jun 2001 22:43:35 +0200
X-Mailer: KMail [version 1.2]
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com> <3B1E5316.F4B10172@illusionary.com> <m1wv6p5uqp.fsf@frodo.biederman.org>
In-Reply-To: <m1wv6p5uqp.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <01060622433500.02053@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 June 2001 20:27, Eric W. Biederman wrote:
> The hard rule will always be that to cover all pathological cases
> swap must be greater than RAM.  Because in the worse case all RAM
> will be in thes swap cache.

Could you explain in very simple terms how the worst case comes about?

--
Daniel
