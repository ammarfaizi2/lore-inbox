Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWEDRT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWEDRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWEDRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:19:56 -0400
Received: from bay105-f19.bay105.hotmail.com ([65.54.224.29]:45464 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751499AbWEDRT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:19:56 -0400
Message-ID: <BAY105-F1952B97471150282623600E9B40@phx.gbl>
X-Originating-IP: [80.100.253.167]
X-Originating-Email: [rwm_rietveld@hotmail.com]
From: "Roy Rietveld" <rwm_rietveld@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: TCP/IP send, sendfile, RAW
Date: Thu, 04 May 2006 17:19:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 04 May 2006 17:19:55.0656 (UTC) FILETIME=[F66E0880:01C66F9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can somebody help me with this.

I'am new to Linux normaly i do programming for RTOS.

I would like to send ethernet packets with 1400 bytes payload.
I wrote a small program witch sends a buffer of 1400 bytes in a endless 
loop.
The problem is that a would like 100Mbits throughtput but when i check this 
with ethereal.
I only get 40 MBits. I tried sending with an UDP socket and RAW socket. I 
also tried sendfile.
The RAW socket gives the best result till now 50 MBits throughtput.

Is there something faster then send or am i doing something wrong.

I'm running kernel 2.6 on a ARM9 core at 177Mhz 32RAM 32Flash.

Sorry for the bad English.

Thanks

Roy Rietveld


