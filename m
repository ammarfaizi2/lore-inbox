Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131190AbQKPRvb>; Thu, 16 Nov 2000 12:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131207AbQKPRvV>; Thu, 16 Nov 2000 12:51:21 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:22029 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S131190AbQKPRvR>;
	Thu, 16 Nov 2000 12:51:17 -0500
Date: Fri, 17 Nov 2000 01:51:16 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Message-ID: <20001117015116.C16835@tetsuo.zabbo.net>
In-Reply-To: <200011161213.NAA27334@ns.caldera.de> <200011161222.EAA18278@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011161222.EAA18278@pizda.ninka.net>; from davem@redhat.com on Thu, Nov 16, 2000 at 04:22:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 04:22:36AM -0800, David S. Miller wrote:

> Sure, that sounds nice.
> 
> Actually, one of the possible "grand plans" for 2.5 is a unified
> "struct device".  I don't know what will actually happen here.

apologies for pointing out the potentially obvoius, but people might
want to investigate 'newbus' while brainstorming about this:

http://www.daemonnews.org/200007/newbus-intro.html

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
