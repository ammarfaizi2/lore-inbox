Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290619AbSARHXd>; Fri, 18 Jan 2002 02:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290620AbSARHXX>; Fri, 18 Jan 2002 02:23:23 -0500
Received: from [202.87.41.13] ([202.87.41.13]:19676 "HELO postfix.baazee.com")
	by vger.kernel.org with SMTP id <S290619AbSARHXM>;
	Fri, 18 Jan 2002 02:23:12 -0500
Message-ID: <001b01c19ff1$2d126700$3c00a8c0@baazee.com>
Reply-To: "Anish Srivastava" <anishs@vsnl.com>
From: "Anish Srivastava" <anishs@vsnl.com>
To: <linux-kernel@vger.kernel.org>
Subject: Memory doesn't free up
Date: Fri, 18 Jan 2002 12:54:28 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am using Linux 2.4.13 on a HP Server with 8 x PIII XEON 700 MHZ with 8GB
RAM

I am facing problems with memory. The system seems to just chew up memory
over a period of time and eventually
I lose control of the box...and have to force a power recycle. This happens
almost everyday.

I am running Oracle 8i and weblogic 5.1.
There are specific cronjobs that run every hour and when they are running
the system starts using up all the physical RAM
and doesnt free up even after the jobs complete. I have 2 Machines with
similar configs and both behave the same.

Any kind of help will be greatly appreciated. Is there a way I can force my
machine to free up memory at given intervals
so that I can run a stable system and dont have to reboot often.

cheers,
Anish Srivastava

