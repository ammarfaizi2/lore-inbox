Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265014AbUFAMnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbUFAMnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAMnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:43:14 -0400
Received: from main.gmane.org ([80.91.224.249]:26760 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265014AbUFAMnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:43:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: BUG FIX: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
Date: Tue, 1 Jun 2004 14:42:25 +0200
Message-ID: <MPG.1b2695fa65d7f2ec9896b3@news.gmane.org>
References: <200406010904.i5194pSo010367@fire-2.osdl.org> <xb7iseb7gtv.fsf@savona.informatik.uni-freiburg.de> <20040601095518.GA1527@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-114-140.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> The kernel works with real keys. There is no real sysrq key. My
> definition of sanity is to base your thinking on reality where possible.

My keyboard has a separate key for SysRq (as much as 
'separate' makes sense for laptop keyboards; it's a Fn-
activated key).

If you want to go the route you're going, all laptop keyboards 
should have the numeric keypad produce the same emulated 
scancodes as some alphanumeric keys. This does sound a little, 
uhm, ridiculous to me.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

