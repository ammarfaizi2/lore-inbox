Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTF0XYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTF0XYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:24:36 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:57062 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264934AbTF0XYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:24:34 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre2
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 28 Jun 2003 01:38:34 +0200
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Message-ID: <m31xxfhz0l.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.

What's wrong with the generic HDLC update then? Are you going to apply it?

ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch
or http://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch

Yes, it applies to 2.4.21-pre7 and later kernels, including 2.4.22-pre2.
I hope it will require "-R" to apply it to pre3...

TIA.
-- 
Krzysztof Halasa
Network Administrator
