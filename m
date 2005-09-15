Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVIOCAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVIOCAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVIOCAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:00:06 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:64749 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030331AbVIOCAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:00:05 -0400
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20050914223206.GA2376@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1126749596.3987.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Sep 2005 11:59:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

On Thu, 2005-09-15 at 08:32, Pavel Machek wrote:
> Hi!
> 
> Here's prototype code for swsusp3. It seems to work for me, but don't
> try it... yet. Code is very ugly at places, sorry, I know and will fix
> it. This is just proof that it can be done, and that it can be done
> without excessive ammount of code.

No comments on the code sorry. Instead I want to ask, could you please
find a different name? swsusp3 is going to make people think that it's
Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
know), how about using that name instead? At least then we'll clearly
differentiate the two implementations and you won't confuse/irritate
users.

Regards,

Nigel


