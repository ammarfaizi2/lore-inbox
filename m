Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275987AbRJKKyP>; Thu, 11 Oct 2001 06:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275988AbRJKKyG>; Thu, 11 Oct 2001 06:54:06 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:43794 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S275987AbRJKKx4>; Thu, 11 Oct 2001 06:53:56 -0400
From: thunder7@xs4all.nl
Date: Thu, 11 Oct 2001 12:53:36 +0200
To: linux-kernel@vger.kernel.org
Subject: asdf
Message-ID: <20011011125336.A5917@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling 2.4.10-ac11 + keyboard fix for my alpha, I noted that
this is still printed very often:

/usr/src/linux-2.4.10ac11/include/linux/interrupt.h:77: warning: `__cpu_raise_softirq' redefined
/usr/src/linux-2.4.10ac11/include/asm/softirq.h:35: warning: this is the location of the previous definition

Good luck,
Jurriaan
-- 
You do understand that in my culture what you have just said would
constitute deliberate and possibly dangerous insult?
	Michelle West - Sea of Sorrows
GNU/Linux 2.4.10-ac10 SMP/ReiserFS 2x1402 bogomips load av: 0.00 0.10 0.07
