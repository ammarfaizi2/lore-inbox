Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136847AbRA1FAz>; Sun, 28 Jan 2001 00:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136852AbRA1FAq>; Sun, 28 Jan 2001 00:00:46 -0500
Received: from slkcpop2.slkc.uswest.net ([206.81.128.2]:12561 "HELO
	slkcpop2.slkc.uswest.net") by vger.kernel.org with SMTP
	id <S136847AbRA1FAm>; Sun, 28 Jan 2001 00:00:42 -0500
Message-ID: <3A73AC65.FC9DD8C@qwest.net>
Date: Sat, 27 Jan 2001 22:21:41 -0700
From: Jacob Anawalt <anawaltaj@qwest.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Knowing what options a kernel was compiled with
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to know what options a running kernel was compiled with,
if you dont have access to the source or configure files it was compiled
off of?

In particular, I am trying to discover if 'advanced router' and 'equal
cost multi path' options are compiled into RH7 kernel-2.2.16-22. I would
also like to know if there is a way to discover this information for
other settings that do not have a /proc entry or other visible object
(eg modules).

I am not following this list currently, so if you would please include
my email in the replies, I would appreciate it.

tia,
Jacob Anawalt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
