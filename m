Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWCATH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWCATH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWCATH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:07:28 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:5062 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750721AbWCATH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:07:27 -0500
Message-ID: <4405F0EC.5060601@bootc.net>
Date: Wed, 01 Mar 2006 19:07:24 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sparc] ppdev lockups?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tried using my Xilinx JTAG adapter to program an AVR ATmega8 microcontroller 
using avrdude-5.1. As soon as avrdude tries to access the parallel port, the 
machine locks up solid: no kernel messages at all, no IP traffic, console is 
locked solid and cursor doesn't flash.

This is on a Sun Ultra 5.

Any ideas?

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
