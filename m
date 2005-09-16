Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVIPHFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVIPHFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbVIPHFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:05:10 -0400
Received: from math.ut.ee ([193.40.36.2]:26874 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1161079AbVIPHFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:05:07 -0400
Date: Fri, 16 Sep 2005 10:04:51 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: snd-usb-audio modpost warnings
Message-ID: <Pine.SOC.4.61.0509161002560.22187@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: todays git snapshot gives these warnings:

   MODPOST
*** Warning: "__compound_literal.200" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.129" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.196" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.191" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.104" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.152" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.145" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.113" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.115" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.125" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.154" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.175" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.95" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.171" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.83" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.131" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.161" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.186" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.133" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.139" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.156" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.165" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.118" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.143" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.193" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.101" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.121" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.123" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.159" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.163" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.111" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.98" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.179" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.198" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.169" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.141" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.181" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.177" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.147" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.167" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.150" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.135" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.80" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.137" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.184" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.92" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.86" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.173" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.109" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.89" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.188" [sound/usb/snd-usb-audio.ko] undefined!
*** Warning: "__compound_literal.127" [sound/usb/snd-usb-audio.ko] undefined!

-- 
Meelis Roos (mroos@linux.ee)
