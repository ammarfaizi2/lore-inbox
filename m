Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUAYUMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAYUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:12:40 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:21476 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265210AbUAYUMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:12:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.8968.349900.566999@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 15:11:52 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
In-Reply-To: <4013D0AA.8060906@blueyonder.co.uk>
References: <4013D0AA.8060906@blueyonder.co.uk>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sid> Andrew Morton wrote:
Sid> Sid Boyce <sboyce@xxxxxxxxxxxxxxxx> wrote:
>>> 
>>> I get this on bootup, Athlon XP2200+
>>> =====================================
>>> Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE
>>> ...
>>> EIP is at test_wp_bit+0x36/0x90

>> oh crap, why does this thing keep breaking? Please send your .config
>> over,
>> thanks.

Sid> Linus aslso asked if 2.6.2-rc1 work -- I shall build it
Sid> shortly. I also get the same error with 2.6.2-rc1-mm3.

It doesn't work for me here, I started with 2.6.2-rc1 and moved up
through mm1 and mm3, all either hind on boot (after the uncompressing
message) or crashed with the test_wp_bit Oops that seems to be going
around.

2.6.1-mm4 is the last stable version that works for me.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
