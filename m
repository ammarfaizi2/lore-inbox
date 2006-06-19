Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWFSGGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFSGGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWFSGGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:06:13 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:3289 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1750922AbWFSGGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:06:13 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
Date: Mon, 19 Jun 2006 08:06:06 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606190806.07400.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello team,

I compiled 2.6.17 and now I see, that cpufreq doesn't work with 2.6.17 (2.6.16 
was fine).

My cpu:
Intel(R) Pentium(R) M processor 1.70GHz
cpu family 6
model 13
stepping 6

Cpufreq doesn't start and also /sys files are not present/created

My config:
[*] CPU Frequency scaling
<*> CPU frequency translation statistics
[*] CPU frequency translation statistics details
governors: <*> performance, powersave, ondemand, conservative
<*> Intel Enhanced SpeedStep
[*] Use ACPI tables to decode valid frequency/voltage pairs
[*] Built-in tables for Banias CPUs 

Thank you for fixing this in 2.6.17.1

Best regards

Michal
