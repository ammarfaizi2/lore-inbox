Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSLYB3T>; Tue, 24 Dec 2002 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbSLYB3T>; Tue, 24 Dec 2002 20:29:19 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:17619 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266020AbSLYB3S> convert rfc822-to-8bit; Tue, 24 Dec 2002 20:29:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Debugging "cpu freezes"
Date: Wed, 25 Dec 2002 02:37:03 +0100
User-Agent: KMail/1.4.3
References: <200212241856.TAA14250@mail41.fg.online.no>
In-Reply-To: <200212241856.TAA14250@mail41.fg.online.no>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Michael <soppscum@online.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212250237.03662.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 December 2002 19:56, Michael wrote:

Hi Michael,

> I'm wondering what the procedure for debugging instances where the computer
> freezes completly, when sysRQ doesn't even work. Since I know how to
> reproduce(and workaround for daily use) a complete system freeze in 2.4.X,
> don't know if I can explain how, but for example booting the knoppix
> live-cd to kde would be a perfect way of freezing it(after moving a few
> windows) (Not using KDE reduces the risk of it freezing greatly)
you could try boot parameter nmi_watchdog=1 or =2
(Read Documentation/nmi_watchdog.txt).

ciao, Marc
