Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270630AbRHJAcY>; Thu, 9 Aug 2001 20:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270631AbRHJAcP>; Thu, 9 Aug 2001 20:32:15 -0400
Received: from MailAndNews.com ([199.29.68.123]:4869 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S270630AbRHJAcC>;
	Thu, 9 Aug 2001 20:32:02 -0400
X-WM-Posted-At: MailAndNews.com; Thu, 9 Aug 01 20:31:18 -0400
Message-ID: <003f01c12133$6d118d00$c405a33e@brekoo.noip.com>
From: "Marc Brekoo" <m_brekoo@mailandnews.com>
To: "Rainer Mager" <rvm@gol.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGIEICELAA.rvm@gol.com>
Subject: Re: [somewhat OT] connecting to a box behind a NAT router
Date: Fri, 10 Aug 2001 02:28:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

> So, my question is, is there any way to get into (telnet or ssh) my box
behind
> the router from outside?

Yes, it's possible :)
See the iptables man-page for that, and look for SNAT & DNAT. If you need
any help with your setup, I'd be happy to help.

Regards,
Marc Brekoo

