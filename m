Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTK0Kpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTK0Kpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:45:42 -0500
Received: from iisc.ernet.in ([144.16.64.3]:54185 "EHLO iisc.ernet.in")
	by vger.kernel.org with ESMTP id S264473AbTK0Kpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:45:41 -0500
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200311271045.QAA10220@eis.iisc.ernet.in>
Subject: kernel development in kernel
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Nov 2003 16:15:30 +0530 (GMT+05:30)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After lots of hesitation I am sending this mail. Hope I don't waste your time.

I am thinking of developing kernel development environment which provides
a pseudo shell, and runtime environment that resides in the kernel itself.
The goal of this exercise is to create an environment that simplifies the 
kernel programming effort by creating a virtual user area that sits above 
kernel but within the kernel protected region. The runtime environment should
provide all that is necesary to build and debug kernel image as if it is a 
C program. 

My wish is that kernel development should eventually become somewhat like
a C development, if not completely, partially, so that the idea takes the 
lead over spending lots of time in getting a code work in kernel.

Sure, too much of hand waving without any substance went in my mail. If you
can let me know the worthwhileness of the effort itself I will be motivated
to slog.

Thanks for your time.

Anand
