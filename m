Return-Path: <linux-kernel-owner+w=401wt.eu-S932077AbXAOWzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbXAOWzV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbXAOWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:55:21 -0500
Received: from mail.velocitynet.com.au ([203.17.154.25]:38115 "EHLO
	m0.velocity.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbXAOWzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:55:20 -0500
Message-ID: <45AC064B.7000107@iinet.net.au>
Date: Tue, 16 Jan 2007 09:55:07 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] AVR32: fix build breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007 09:37:35 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
 >
 > On Mon, 15 Jan 2007 14:48:57 +1100
 > Ben Nizette <ben.nizette@iinet.net.au> wrote:
 >
 >> Remove an unwanted remnant of the recent revert of AVR32/AT91 SPI 
patches in -mm.  Without this patch, the AVR32 build of 
2.6.20-rc[34]-mm1 breaks.
 >
 > Actually, this is broken in my tree. Wonder how I managed to do that
 > and not even notice it.
 >

Interestly git://www.atmel.no/~hskinnemoen/linux/kernel/avr32.git master 
is still fine

 > I'll apply this patch and push out a new avr32-arch branch for Andrew.
 > Thanks for testing.

Sounds good, no worries.

--Ben
 >
 > Haavard
 >
