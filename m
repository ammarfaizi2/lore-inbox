Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVLXOqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVLXOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 09:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVLXOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 09:46:09 -0500
Received: from mail.linicks.net ([217.204.244.146]:58600 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750748AbVLXOqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 09:46:08 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [Question] BIOS settings
Date: Sat, 24 Dec 2005 14:45:58 +0000
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512241445.59092.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody, and seasons greetings,

I was reading up on the web, and saw that BIOS `video shadowing' isn't 
required with modern kernels, as the kernel talks direct to the hardware 
bypassing BIOS.  I was aware of this re boot time, and know that kernel 
queries hardware direct - but didn't know this bit.

I have an KT7 mobo with award BIOS (version year 2000) and GeForce4 MME with 
nVidia 'secret squirrel' module [kernel 2.6.14.4], so turned off video 
shadowing.

Now, glxgears (I know it not a measurement tool, but...) runs at an amazing 
400fps faster (it was 750ish, now runs at 1100ish in same environment).

So, my question is - are there any documentation that covers what is needed 
and isn't needed in setting up optimum BIOS settings for Linux kernels?

Regards,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
