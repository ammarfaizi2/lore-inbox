Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSKEU22>; Tue, 5 Nov 2002 15:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSKEU21>; Tue, 5 Nov 2002 15:28:27 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:8598 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265197AbSKEU21>; Tue, 5 Nov 2002 15:28:27 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Willy Tarreau <willy@w.ods.org>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021105145542.734A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021105145542.734A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 20:57:04 +0000
Message-Id: <1036529824.6757.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 20:23, Richard B. Johnson wrote:
> Hey, look. I can only warn. You do what you want. As far as I'm
> concerned support stopped at Linux 2.4.19 when poll got trashed.
> Nobody can use 2.4.19 or probably anything later unless they have
> powerful CPUs that can spin with 1000 SIGPOLL signals per second.

My 486SLC33 (running at 8MHz on battery mode) doesn't believe you.

