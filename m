Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbUKUXVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbUKUXVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbUKUXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:21:12 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:31480
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261838AbUKUXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:21:09 -0500
Message-ID: <41A122E0.8070307@eyal.emu.id.au>
Date: Mon, 22 Nov 2004 10:21:04 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: help: sysrq and X
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to diagnose a hard lockup. The only way I can reproduce it is
with mythtv. When the system locks up (no mouse, no activity in X, no message
logged) I can use magic sysrq, but I cannot see the output.

Using 'r' does not enable console switching. However 'b' will boot the
system, and I hope 's' and 'u' did something blindly.

I there a way to regain a text console in order to inspect the kernel?

I can connect a machine to the serial port if this will help - does
sysrq work though the serial port? Which software should I use on
the serial port (on the 'other' machine) for this purpose then?

Thanks

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
