Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277148AbRJLBr0>; Thu, 11 Oct 2001 21:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277145AbRJLBrQ>; Thu, 11 Oct 2001 21:47:16 -0400
Received: from sushi.toad.net ([162.33.130.105]:25275 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277148AbRJLBq7>;
	Thu, 11 Oct 2001 21:46:59 -0400
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
From: Thomas Hood <jdthood@mail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110112241.f9BMfWM27107@deathstar.prodigy.com>
In-Reply-To: <200110112241.f9BMfWM27107@deathstar.prodigy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 11 Oct 2001 21:45:41 -0400
Message-Id: <1002851144.10317.18.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 18:41, bill davidsen wrote:
> Does this address any bug present without the cast?

No.  There's no bug.  The debate is over whether or not
it's naughty to cast -1 to unsigned long.

--
Thomas

