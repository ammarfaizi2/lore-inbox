Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVGEJYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVGEJYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVGEJYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:24:23 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:18163 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261771AbVGEJYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:24:22 -0400
Message-ID: <42CA5105.60505@inwind.it>
Date: Tue, 05 Jul 2005 11:21:09 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: setkeycodes, sysrq, and USB keyboard
References: <42C9AD67.5050808@inwind.it> <20050704220532.GA2086@ucw.cz>
In-Reply-To: <20050704220532.GA2086@ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik ha scritto:

>Sorry, you can't use 'setkeycodes' on USB keyboards. They don't use the
>PS/2 protocol, and hence it doesn't make sense.
>  
>
ouch! cannot push SysRq?!?
do I still need my PS/2 keyboard plugged in?

(that keyboard is terribly useful because it is a USB hub... but having
the need to plug a PS/2 keyboard whenever X locks up is a waste of
forces... and a waste of keyboards)

isn't there a workaround for this??
an option in the kernel .config to hardcode sysrq-scancodes would be
fine. sorry but i never look in the deep of the kernel. if you point me
to some branch of the kernel maybe i could hack it :9

ciao!

-- 
Federico

