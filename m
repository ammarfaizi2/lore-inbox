Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290557AbSAYFGF>; Fri, 25 Jan 2002 00:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290565AbSAYFFz>; Fri, 25 Jan 2002 00:05:55 -0500
Received: from beasley.gator.com ([63.197.87.202]:44041 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S290557AbSAYFFq>; Fri, 25 Jan 2002 00:05:46 -0500
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: Linux console at boot
Date: Thu, 24 Jan 2002 21:05:45 -0800
Message-ID: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to stop the console scrolling during boot? My reason
for this is I am trying to troubleshoot a boot problem with
2.4.18-pre7 and I would like to give a more useful report than "it
won't boot" but the screen outputs information every few seconds and I
can't "freeze" the display so I can copy down the initial error(s).

This is an Intel unit using the standard console (not serial console).
pre7 will not boot but pre6 boots every time.


