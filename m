Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268354AbTAMVcF>; Mon, 13 Jan 2003 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268352AbTAMVcF>; Mon, 13 Jan 2003 16:32:05 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:759 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268354AbTAMVcE>;
	Mon, 13 Jan 2003 16:32:04 -0500
Date: Mon, 13 Jan 2003 22:40:45 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Edward Tandi <ed@efix.biz>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
Message-ID: <20030113214045.GC1327@k3.hellgate.ch>
Mail-Followup-To: Edward Tandi <ed@efix.biz>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <1042489183.2617.28.camel@wires.home.biz> <20030113210245.GB1327@k3.hellgate.ch> <1042492357.2819.37.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042492357.2819.37.camel@wires.home.biz>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.57 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003 21:12:37 +0000, Edward Tandi wrote:
> > IIRC the KT400 comes with a VT8235 south bridge, so current stock kernel
> > should work (minus some bugs that still need fixing). What does lspci -vn
> > say? Anything in the kernel log when you try to load via-rhine?
> 
> I have the via-rhine driver built into the kernel (Y) not (M). Nothing
> shows in dmesg or /var/log/messages.
> 
> lspci output below. Thanks,

Huh? I'll be... You may want to give b44 a try (I suppose tulip works for
the Lite-On). There's no Rhine here.

Roger
