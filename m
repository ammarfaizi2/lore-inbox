Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUDERH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDERH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:07:29 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:24708 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262602AbUDERHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:07:24 -0400
Message-ID: <001d01c41b30$ab7a0fa0$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <002101c41b00$3f0f8c30$1530a8c0@HUSH> <c4rku2$9dh$2@news.cistron.nl>
Subject: Re: Network issues in 2.6
Date: Mon, 5 Apr 2004 19:08:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Note that for TX packets, the carrier number is almost the same as the
total
> >packets.... booting in 2.4.22, there are zero problems.  The only
difference
> >in the ifconfig, other than that, is that in 2.4.22, I have "RUNNING" in
the
> >options (but I didn't find how to force that).
>
> Have you tried upgrading your 'ifconfig' ?

net-tools 1.60
ifconfig 1.42 (2001-04-13)

Didn't find a newer one, but still, the problem's cause gotta be somewhere
else.
Or not?

