Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262940AbTC0OKH>; Thu, 27 Mar 2003 09:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbTC0OKG>; Thu, 27 Mar 2003 09:10:06 -0500
Received: from rth.ninka.net ([216.101.162.244]:1420 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262940AbTC0OKC>;
	Thu, 27 Mar 2003 09:10:02 -0500
Subject: Re: Obsolete messages ...
From: "David S. Miller" <davem@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048774874.19677.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Mar 2003 06:21:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 18:57, Davide Libenzi wrote:
> Any CONFIG_DROP_FREAKIN_OBSOLETE_MSGS (SO_BSDCOMPAT,bdflush,...) anywhere
> soon in 2.5.67 ? :)

If you fix the apps, the messages go away.  In fact, you want to know
that you have unfixed apps on your box when you run these kernels so
I'd say the messages should stay even well into early 2.6.x

-- 
David S. Miller <davem@redhat.com>
