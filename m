Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRCCQDu>; Sat, 3 Mar 2001 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRCCQDl>; Sat, 3 Mar 2001 11:03:41 -0500
Received: from mail.ask.ne.jp ([203.179.96.3]:64676 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S129175AbRCCQDX>;
	Sat, 3 Mar 2001 11:03:23 -0500
Date: Sun, 4 Mar 2001 01:01:45 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: John R Lenton <john@grulic.org.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IMS Twin Turbo 128 framebuffer
Message-Id: <20010304010145.1d6a1dfb.bruce@ask.ne.jp>
In-Reply-To: <20010302203231.E1640@grulic.org.ar>
In-Reply-To: <20010302203231.E1640@grulic.org.ar>
X-Mailer: Sylpheed version 0.4.61 (GTK+ 1.2.6; Linux 2.2.18; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Mar 2001 20:32:31 -0300
John R Lenton <john@grulic.org.ar> wrote:
> Is there any particular reason why imsttfb isn't available in the
> i386 arch?

I believe it's because the Twin Turbo was introduced into the kernel via
the PPC kernel port - was there actually a TT board for PCs? I'm not
talking about bus (the TTs were all PCI, IIRC), but rather the firmware on
the board - does it work on x86? If not, can it be flashed? If it can't,
you're out of luck.

--
Bruce Harada
bruce@ask.ne.jp

