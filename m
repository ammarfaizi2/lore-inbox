Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313327AbSDUO1x>; Sun, 21 Apr 2002 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313330AbSDUO1w>; Sun, 21 Apr 2002 10:27:52 -0400
Received: from netroute.netroute.cz ([62.40.73.2]:49854 "HELO
	netroute.netroute.cz") by vger.kernel.org with SMTP
	id <S313327AbSDUO1v>; Sun, 21 Apr 2002 10:27:51 -0400
Message-ID: <000501c1e940$b83c68b0$1b00a8c0@guru>
From: "Vladimir Trebicky" <trebi@post.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Alias interface statistics
Date: Sun, 21 Apr 2002 16:27:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read somewhere that linux does not support throughput statistics
(which could be very usable for example in snmp) for aliased (virtual)
interfaces like eth0:1. I want to monitor traffic on those interfaces with
mrtg snmp but don't how in that case. Is there any chance that it could be
corrected in newer versions of kernel?

--
Vladimir Trebicky
trebi@post.cz

