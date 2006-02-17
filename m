Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWBQJSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWBQJSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBQJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:18:03 -0500
Received: from iona.labri.fr ([147.210.8.143]:8850 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932589AbWBQJSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:18:01 -0500
Message-ID: <43F59457.4030500@labri.fr>
Date: Fri, 17 Feb 2006 10:16:07 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux on iPod
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently discovered that I could run Linux on an iPod
(http://ipodlinux.org/). The problem is that they seems to use an old
version of the uclinux kernel (2.4.x serie) adapted for the PP500x/PP502x.

I have few questions about this:

1) I tried to look how to configure a kernel (through menuconfig) to get
access to non-MMU able CPUs, but I failed. What is the trick ? :)

2) The PP500x/PP502x chipset serie seems to be a dual-ARM7, is there any
plan to support this architecture (even something experimental could fit
to me).

That's all folks
-- 
Emmanuel Fleury

Susie: When life gives you a lemon, make lemonade.
Calvin: I say, when life gives you a lemon, wing it right back
and add some lemons of your own!
  -- Calvin & Hobbes (Bill Waterson)
