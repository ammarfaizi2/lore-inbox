Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbTLIPXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266047AbTLIPXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:23:06 -0500
Received: from [213.229.38.66] ([213.229.38.66]:52106 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S266046AbTLIPXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:23:02 -0500
Message-ID: <3FD5E852.1000902@winischhofer.net>
Date: Tue, 09 Dec 2003 16:20:50 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: sisfb driver update (Was: Re: 2.4.23aa1 - scsi/pcmcia qlogic still
 does not build (m))
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eyal, Andrea,
 > yes I've a 150k compressed updated driver from Thomas Winischhofer in
 > my inbox for Marcelo that should fix those bugs (that would obsolete
 > the non complete 00_sis-fpu-bugs-1), I thought it was merged in
 > mainline but obviously not as 00_sis-fpu-bugs-1 wouldn't apply
 > anymore. I guess Marcelo rejected it because it was very big and it
 > wasn't fix the strict fpu bugs revealed by the -msoft-float, just
 > guessing.

Yeah, I assume it was too big for pre9 stage at that time.

However, I have sent another update for the sisfb driver to Marcello for 
inclusion in 2.4.24pre but the patch has not yet found its way into bk.

In the meantime, you can use the replacement driver from my website.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org




