Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270605AbRHIX0h>; Thu, 9 Aug 2001 19:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269875AbRHIX01>; Thu, 9 Aug 2001 19:26:27 -0400
Received: from [64.56.164.18] ([64.56.164.18]:59149 "EHLO www.vgkk.com")
	by vger.kernel.org with ESMTP id <S269874AbRHIX0S>;
	Thu, 9 Aug 2001 19:26:18 -0400
From: "Rainer Mager" <rvm@gol.com>
To: <linux-kernel@vger.kernel.org>
Subject: [somewhat OT] connecting to a box behind a NAT router
Date: Fri, 10 Aug 2001 08:25:59 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGIEICELAA.rvm@gol.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I'm about to get ADSL installed for my home Internet connection and have
chosen to do this via an ADSL router (as opposed to a modem). The router
will have a static/global IP address but everything behind it will be
connecting through the router via NAT. So, my question is, is there any way
to get into (telnet or ssh) my box behind the router from outside?
	Is there some sort of tunneling protocol/tool to do this? If so, what
happens if I want to connect two boxes is the same situation (behind NAT
routers)? Is is still possible? Is is interoperable with Windows and Linux?

	Any ideas would be greatly appreciated.


Thanks in advance,

--Rainer

