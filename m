Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbUKXTkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbUKXTkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUKXTkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:40:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:17938 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262806AbUKXTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:40:01 -0500
Message-ID: <41A4E37C.7060501@techsource.com>
Date: Wed, 24 Nov 2004 14:39:40 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Clocks stopped drifting!  What happaned?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It used to be that on every computer where I was using Linux, the clocks 
would drift really badly.  After a few weeks, they'd all be fast by as 
much as 30 minutes, and it got to be annoying to have to periodically 
reset the time.  For instance, this was the case for both a Dell with a 
1.8GHz Pentium 4 and for a home-built PC with an Athlon XP 2800+ (via 
KT400 chipset).

I just realized that since I upgraded to 2.6.9, that problem has gone 
away.  I'm not using NTP, but my clocks are suddenly reliable.

What happened?
