Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUJJK2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUJJK2M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 06:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUJJK2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 06:28:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:8965 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268225AbUJJK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 06:28:08 -0400
Date: Sun, 10 Oct 2004 12:28:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Yoshinori K. Okuji" <okuji@gnu.org>
Cc: linux-kernel@vger.kernel.org, videolan@videolan.org
Subject: Re: possible GPL violation by Free
Message-ID: <20041010102802.GH19761@alpha.home.local>
References: <200410091958.25251.okuji@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410091958.25251.okuji@gnu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 09, 2004 at 07:58:25PM +0200, Yoshinori K. Okuji wrote:
> I got information about a possible GPL violation in France. A network
> service company called "Free" provides a kind of ADSL modem named
> "Freebox". This "Freebox" is not only an ADSL modem but also has
> functions of a router, an IP phone and a TV, using video streaming via
> ATM. Although the "Freebox" does not contain any information about GPL,
> a rumor says that this runs Linux as the kernel and VideoLAN for the
> video streaming.

When they built the first freebox, I found an inside photo on the net.
I don't remember which chip it was (several years ago), but it was clear
from the maker that it only supported vxworks. And at this time, people
were already saying it was running linux. There are so many rumors about
many devices running linux that people should check (at least provide the
result of an nmap -O). For most end-users, "linux" is the word for "a
reliable embedded OS with IP support".

However, I also found a photo of the new one on the net, which shows
a big broadcom BCM6348. This one supports both linux and vxworks, but
judging by the number of responses on google, there is a great chance
that broadcom pushes linux on it since they also provide many other
solutions involving linux.

Regards,
Willy

