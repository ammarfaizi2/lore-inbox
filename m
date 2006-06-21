Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWFUG0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWFUG0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFUG0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:26:48 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:10179 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751149AbWFUG0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:26:47 -0400
From: CIJOML <cijoml@volny.cz>
To: jkmaline@cc.hut.fi, linux-kernel@vger.kernel.org
Subject: 2.6.17 - hostap_cs: unexpected IRQ trap at vector b0 and kernel freeze :(
Date: Wed, 21 Jun 2006 08:26:40 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606210826.40184.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jouni,

I have problem with 2.6.17 kernel.

When I insert card or boot with card in pcmcia slot, kernel always freezes!

dmesg:
hostap_cs: Registered netdevice wifi0
unexpected IRQ trap at vector b0
hostap_cs: index 0x01, irq3, io 0x3100-0x313f
kernel freeze

up to 2.6.16 everythink worked fine!

Can you please fix this ASAP? This is my only connection to the internet.

Thanks

Michal
