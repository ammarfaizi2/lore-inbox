Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbUJ1Lvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUJ1Lvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUJ1LtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:49:03 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:2547 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262988AbUJ1Lq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:46:56 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: wd module doesn't work in 2.4 and 2.6 ???
Date: Thu, 28 Oct 2004 13:46:32 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410281346.32206.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have an old SMC card named SMC EtherCard Plus Elite 16 Combo (WD 8013EW or 
8013EWC)

it should work with module wd.

Under win95 :) it works great with

io=0x300 irq=15 mem=0xc8000 mem_end=0xcvfff

When I modprobe wd with these params, both 2.4 and 2.6 kernels tells me

No wd80x3 card found (io=0x300)

PLS help me. Where is problem???

Michal
