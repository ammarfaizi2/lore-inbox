Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSHSEgC>; Mon, 19 Aug 2002 00:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSHSEgC>; Mon, 19 Aug 2002 00:36:02 -0400
Received: from pa13.bydgoszcz.sdi.tpnet.pl ([213.25.7.13]:18954 "HELO
	pa13.bydgoszcz.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S317931AbSHSEgB>; Mon, 19 Aug 2002 00:36:01 -0400
Date: Mon, 19 Aug 2002 06:39:41 +0200
From: "Tomasz Torcz, BG" <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4 and full ipv6 - will it happen?
Message-ID: <20020819043941.GA31158@irc.pl>
Mail-Followup-To: "Tomasz Torcz, BG" <zdzichu@irc.pl>,
	linux-kernel@vger.redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time ago Linux was first OS to have full RFC complaint IPv4 stack.
Linux still has superior networking, but protocol of the future is IPv6.
IPv6 stack in mainline is currently far from perfect. There is a hope,
however. Full IPv6 stack is beeing mantained by USAGI project. It's
clear, that USAGI's project will be integrated into mainline kernel.
What worries me - it's planned for 2.7, what is _BAD_ and late.
IMO, it can be included in any time. The sooner is better.
Marcelo - would you include full IPv6 stack in 2.4.20 if you get patches?
Please - it's important for Linux to be network OS choice in future.
It's barely possible with current IPv6 implementation.

My another concern is that Linux on Sparc machines is very unstable,
and main polish 6bone router - beeing a sparc machine - is not very
reliable. But that's another story.

-- 
Tomasz Torcz           Zjadanie martwych dzieci
zdzichu@irc.pl           jest barbarzynstwem!
