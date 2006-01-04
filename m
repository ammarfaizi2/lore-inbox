Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWADIbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWADIbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWADIbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:31:47 -0500
Received: from [203.199.255.5] ([203.199.255.5]:50341 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S1751212AbWADIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:31:47 -0500
Date: Wed, 4 Jan 2006 14:02:30 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.tenet.res.in>
X-X-Sender: pmanohar@lantana.cs.iitm.ernet.in
To: linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Lantana Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.tenet.res.in
Subject: keyboard driver of 2.6 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,
     I have a small doubt in Linux kernel keyboard driver.
In 2.4 kernels the starting fuction of keyboard driver is "handle_scancode". 
But in 2.6 kernels the keyboard interface
is changed drastically.  If you familiar with that can you tell me the starting 
fuction of keyboard interace which gets
the scancodes in 2.6 kernels.

Actually my paln is to stuff scancodes or keycodes to the keyboard buffer 
, from there on the keyboard driver processes them.  I have done this for 
2.4 kernel.  I want to implement the same to 2.6 kernel.

Is there any keyloggers which are implemented for 2.6 kernels?

Thanks In Advance
P.Manohar.


