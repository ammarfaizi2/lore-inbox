Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRKTTmq>; Tue, 20 Nov 2001 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281289AbRKTTmc>; Tue, 20 Nov 2001 14:42:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:43272 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281284AbRKTTlM>;
	Tue, 20 Nov 2001 14:41:12 -0500
Date: Tue, 20 Nov 2001 20:41:05 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: problem with NAT on 2.4
Message-Id: <20011120204105.4785bc97.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a SuSE 7.3 distro kernel 2.4.10 and ran into some really strange
problem with NAT. I have a private network setup (192.168.3.x) with win-clients
(win98, W2K) and a variety of IE-browsers. From this network I wanted to grant
direct access to the internet via NAT. Basically it works, but what does not
work is a http-connection from _any_ tested win client over linux NAT to a
certain MS IIS 5.0.
I wouldn't be that bothered if the exact same clients wouldn't connect
flawlessly over a 50 bucks DSL-router to the same IIS. Other servers (whatever
I tried) seem to work, but not the really important one (Murphy of course ;-).
Does anybody have an idea why NAT in 2.4.10 wouldn't work like NAT in some
cheap dsl-router equipment regarding http-connections?
Is there any sense in upgrading to 2.4.15-preX?
I even tried some gateway software based on windoze that is able to NAT - and
it works too! I pretty much ran out of ideas...

Regards,
Stephan
