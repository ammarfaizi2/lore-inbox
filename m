Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268670AbRG3W2h>; Mon, 30 Jul 2001 18:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268665AbRG3W21>; Mon, 30 Jul 2001 18:28:27 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:15260
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S268645AbRG3W2Q>; Mon, 30 Jul 2001 18:28:16 -0400
Date: Mon, 30 Jul 2001 15:28:22 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Sridhar Samudrala <samudrala@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
 Prioritized Accept Queue
In-Reply-To: <Pine.LNX.4.21.0107301359350.23307-100000@w-sridhar2.des.sequent.com>
Message-ID: <Pine.LNX.4.33.0107301526230.8520-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Sridhar Samudrala wrote:

> oss.software.ibm.com is running linux 2.2.19. I guess linux should by
> default ignore ECN bits if it is not enabled. Do you think this ECN problem
> has something to do with the server or some router on the way the server?

ibm's [lotus's] firewall is blocking packets with ecn bits turned on.
http://gtf.org/garzik/ecn/


justin

