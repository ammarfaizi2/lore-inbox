Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbRFXWpW>; Sun, 24 Jun 2001 18:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265778AbRFXWpM>; Sun, 24 Jun 2001 18:45:12 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:11278 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S265777AbRFXWpC>; Sun, 24 Jun 2001 18:45:02 -0400
Message-ID: <001301c0fcff$47c05160$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Subject: GCC3.0 Produce REALLY slower code!
Date: Mon, 25 Jun 2001 02:44:51 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2488.0001
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2488.0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!
Some tests that I have recently check out.
kernel compiled with 3.0 (2.4.5) function call: 1000000 iteration. 3% slower
than 2.95.
test example - hash table add/remove - 4% slower (compiled both
with -O2 -march=i686).
Why have this version been released?
Best regards,
Alexander         mailto:dmor@7ka.mipt.ru

