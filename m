Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283375AbRLEPmb>; Wed, 5 Dec 2001 10:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRLEPmX>; Wed, 5 Dec 2001 10:42:23 -0500
Received: from colorfullife.com ([216.156.138.34]:7186 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283274AbRLEPmO>;
	Wed, 5 Dec 2001 10:42:14 -0500
Message-ID: <3C0E4055.4060201@colorfullife.com>
Date: Wed, 05 Dec 2001 16:42:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <XFMail.20011205094744.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:

>
>It's very useful to log when a lock(irq) is held more than xx ms
>and who is the caller. Is it possible ?
>
Have you looked at SGI's lockmeter patch?
It's very good to check performance numbers of spinlocks.

--   
    Manfred

