Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268563AbRGYMzf>; Wed, 25 Jul 2001 08:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268561AbRGYMzQ>; Wed, 25 Jul 2001 08:55:16 -0400
Received: from zeus.kernel.org ([209.10.41.242]:40925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268562AbRGYMzL>;
	Wed, 25 Jul 2001 08:55:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman), landley@webofficenow.com
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 14:53:04 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva> <01072415352102.00631@localhost.localdomain> <m1vgkhh0j5.fsf@frodo.biederman.org>
In-Reply-To: <m1vgkhh0j5.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <01072514530401.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25 July 2001 10:32, Eric W. Biederman wrote:
> Consider having a swapfile on tmpfs.

Ooh, a truly twisted thought.

We'd know we're making progress when we can prove it doesn't deadlock.

--
Daniel
