Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262082AbTCVKGp>; Sat, 22 Mar 2003 05:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbTCVKGo>; Sat, 22 Mar 2003 05:06:44 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:1489 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id <S262082AbTCVKGo>;
	Sat, 22 Mar 2003 05:06:44 -0500
Date: Sat, 22 Mar 2003 11:17:20 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Alon <alon@gamebox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine timeouts
Message-ID: <20030322101720.GA18378@k3.hellgate.ch>
Mail-Followup-To: Alon <alon@gamebox.net>,
	linux-kernel@vger.kernel.org
References: <20030321232047.D7D771800D2@smtp-2.hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321232047.D7D771800D2@smtp-2.hotpop.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.65 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (in fact, an onboard chip in the ECS L7VTA-L motherboard)
> completely refuses to make a connection under 2.4.x kernels.
> I tried all releases between 2.4.18 and current 2.4.21-pre5
> to no avail. The driver provided by VIA at their site
> fared no better.
> [...]
> The weird thing is, it seems to work perfectly with
> Debian Woody's stock 2.2.20 idepci kernel. I'd be glad

If you have APIC support on, try turning it off.

Roger
