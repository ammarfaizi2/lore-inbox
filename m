Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293432AbSCKBHP>; Sun, 10 Mar 2002 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293434AbSCKBHG>; Sun, 10 Mar 2002 20:07:06 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:35514 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293432AbSCKBGx>; Sun, 10 Mar 2002 20:06:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Koeller <tkoeller@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: epic100 problem
Date: Mon, 11 Mar 2002 02:06:54 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020311010655.D38B512000C@sarkovy.koeller.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the epic100 network card driver module, after upgrading from kernel 
2.4.17 to 2.4.18 I experienced problems with my network cards, of which I
have two. The first (eth0) serves my home network and seems to be
working just fine, but the second one (eth1), connected to my ADSL modem
is almost non-functional. I can hardly get connected after many failing attempts.
I used tcpdump to check the outgoing packets, everything looks normal on that
level. The 'send' LED flashes as data packets are sent, but I do not receive any
response at all.

I installed the epic100 module from kernel 2.4.17 again, and everything was
functioning again. My system is a x86 PC.

I am not subscribed to the kernel mailing list, so please CC me when
responding.

Thomas

-- 
Thomas Koeller
tkoeller@gmx.net
