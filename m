Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281811AbRK1GUM>; Wed, 28 Nov 2001 01:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281777AbRK1GUD>; Wed, 28 Nov 2001 01:20:03 -0500
Received: from okcforum.org ([207.43.150.207]:50440 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S281591AbRK1GTO>;
	Wed, 28 Nov 2001 01:19:14 -0500
Subject: Unresponiveness of 2.4.16 revisited
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 00:19:03 -0600
Message-Id: <1006928344.2613.2.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I tried your patch Andrew. It seemed to have absolutely no effect
on my problem. I used the am-response.patch someone posted the url to
eariler in the first thread, which was just a file of your patch. I
really suggest you try a mozilla source rpm. Not only does it do the
unarchiving, but also patches and rm -rf. I often see a second pause
during the patching after the unarchving. I use

rpm --rebuild mozilla-2001112602_trunk-0_rh7.src.rpm


I also tried Redhat's latest rawhide kernel, 2.4.16-0.1 and it had to
had time same problem. So it isn't fixed by one of their patchs. It is
most likely just a difference between Linus's 2.4.9 and 2.4.16.

