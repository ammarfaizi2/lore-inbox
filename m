Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277769AbRJIPP2>; Tue, 9 Oct 2001 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277755AbRJIPPI>; Tue, 9 Oct 2001 11:15:08 -0400
Received: from [12.2.11.164] ([12.2.11.164]:14602 "EHLO www.bradycorp.com")
	by vger.kernel.org with ESMTP id <S277767AbRJIPO6> convert rfc822-to-8bit;
	Tue, 9 Oct 2001 11:14:58 -0400
Subject: kapmidled and AMD K6-2
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Edition France 5.0.2c 8 =?iso-8859-1?q?f=E9vrier_2000?=
Message-ID: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com>
From: Jose_Jorge@teklynx.fr
Date: Tue, 9 Oct 2001 16:15:20 +0100
X-MIMETrack: Serialize by Router on GHOWBL01/BradyWeb(Release 5.0.5 |September 22, 2000) at
 10/09/2001 10:03:46 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have read all recent mails about this misunderstooded change in 2.4
series. But as no one reports heating, I do :

for the AMD K6-2 on a DFI motherboard AT/ATX, using the AT power supply,
this option is buggy. I mean the cycles kapmidled works doesn't cool the
processor, they hot him.

This stops as soon as I uncheck the option "Send Halt command on idle" in
the APM settings of the kernel.

José

P.S.:please CC to my address, as I am not subscriber of this list


