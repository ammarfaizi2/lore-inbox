Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbRGMWH3>; Fri, 13 Jul 2001 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbRGMWHR>; Fri, 13 Jul 2001 18:07:17 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:10246 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267559AbRGMWHI>; Fri, 13 Jul 2001 18:07:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Thomas Foerster <puckwork@madz.net>
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Date: Sat, 14 Jul 2001 00:05:42 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010713111652Z267032-720+1961@vger.kernel.org>
In-Reply-To: <20010713111652Z267032-720+1961@vger.kernel.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01071400054201.30655@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 July 2001 13:12, Thomas Foerster wrote:

> I got only one oops in inode.c (forget the actual line number)
> The rest are random application crashes on XFree 4.0.3 (GeForce2 GTS, nVidi
> DRI (older version)) The System NEVER hangs, only applications crash!
So this is off-topic, but anyway here is my experience:
The binary-only Nvidia driver consistently deep-froze my system, 
i.e. screen and keyboard were dead. The system log showed, however, 
that the system was still alive. Just forget the Nvidia driver...

My 2c,
Stefan   

-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
