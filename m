Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFCVp0>; Mon, 3 Jun 2002 17:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSFCVpZ>; Mon, 3 Jun 2002 17:45:25 -0400
Received: from [213.4.129.129] ([213.4.129.129]:49306 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S315595AbSFCVpZ>;
	Mon, 3 Jun 2002 17:45:25 -0400
Date: Mon, 3 Jun 2002 23:46:05 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Andrey Panin <pazke@orbita1.ru>
Cc: bvermeul@devel.blackstar.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
Message-Id: <20020603234605.073cc9da.diegocg@teleline.es>
In-Reply-To: <20020603135908.GA306@pazke.ipt>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002 17:59:08 +0400
Andrey Panin <pazke@orbita1.ru> escribió:

> 
> On my machine kicker showed a message about inability to parse IIRC 
> /proc/meminfo before dying, so the kernel can be involved.

yes, /proc/meminfo might have changed?. i've a gnome applet which shows
cpu, mem and swap usage. Under 2.5 tree, i only can see the cpu usage.
Others doesn't work
