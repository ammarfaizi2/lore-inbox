Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbREXWsQ>; Thu, 24 May 2001 18:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbREXWsG>; Thu, 24 May 2001 18:48:06 -0400
Received: from smtp2.vol.cz ([195.250.128.42]:49930 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S262466AbREXWr6>;
	Thu, 24 May 2001 18:47:58 -0400
Message-ID: <000b01c0e4a3$9c96bae0$1700000a@kamamura>
From: "Tomas Styblo" <trip@matrix.cyberspace.cz>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 freezes on VIA KT133
Date: Fri, 25 May 2001 00:48:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've yet seen similar freeze reports here in the past, so I decided to post
my one too.
The said system is a server, Athlon 850, no overclocking, no overheating,
100 Mhz FSB, 512 MB brand RAM, Abit KT7A board with VIA KT133.

The system is heavy loaded in daytime, but almost idle at night. It crashes
only about three times per month. These freezes
started to happen after 2.2 -> 2.4 upgrade, that I performed early after the
2.4.1 revision was released. These crashes are completely untracable for me,
because there is nothing suspicious in the syslog afterwards. Also the
system runs ABSOLUTELY perfectly between the crashes  - no problems with
kernel compilations or similar tasks that push the system over stability.

The crashes occur absolutely unpredictably, sometimes even at night, when
the system is idle.

The system runs various network services and dynamic web applications that
use the MySQL database a lot. The only used filesystem is EXT2. I do not use
buggy redhat compiler.

This report is probably not very helpful, but it may be useful for those who
planned to purchase AMD / VIA solution for a server.
I am not subscribed to this list, but I will monitor it through a web
archive and will try to respond, if needed.

Thanks for your work !
Tomas Styblo


