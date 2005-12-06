Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVLFF10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVLFF10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLFF10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:27:26 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:16071 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964827AbVLFF1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:27:25 -0500
Subject: Re: Nick's preempt nosched patch.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1133844903.5501.17.camel@localhost>
References: <1133844903.5501.17.camel@localhost>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133846622.5501.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 15:23:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Tue, 2005-12-06 at 15:02, Nigel Cunningham wrote:
> Hi.
> 
> A while ago I had a problem with cpu hotplug failing to take down cpus
> due to preemption problems. Nick prepared a patch (included below) that
> fixed this, but it's not yet in mainline. The problem seems to have
> disappeared on my work desktop (so I thought it had been applied until I
> did a quick check), but a suspend2 user has just reported the problem
> again. Can look at applying this or something better in mainline,
> please?

Ah. I eat my words, having discovered that it has been merged since
2.6.14, which I was looking at earlier. Sorry for the noise.

Nigel

