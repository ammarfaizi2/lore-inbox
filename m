Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280130AbRKOC3I>; Wed, 14 Nov 2001 21:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280136AbRKOC27>; Wed, 14 Nov 2001 21:28:59 -0500
Received: from host-21.50by.nyc.onsiteaccess.net ([216.89.84.21]:62724 "EHLO
	mailessentials.wagweb.com") by vger.kernel.org with ESMTP
	id <S280130AbRKOC2u> convert rfc822-to-8bit; Wed, 14 Nov 2001 21:28:50 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <3BF3285B.D4F6EFC8@wagweb.com>
Date: Wed, 14 Nov 2001 21:28:43 -0500
From: "Madhav Diwan" <mdiwan@wagweb.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: <linux-kernel@vger.kernel.org>
Subject: tty stuff
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 15 Nov 2001 02:29:48.0359 (UTC) FILETIME=[6574FD70:01C16D7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arrrgh

How do i get the kernel messages to stop interupting my scripting? 
( YeS im editing as root .. because the files i edit are in roots
directory and are often executables.. yes i know thats bad)

I want to divert them all to the console tty1 ( why is the first console
tty1 and not tty0? )... or just not interrupt a vi session by not
posting to the screen when i am editing ?

Maybe there is a curses vi clone editor that can give me this?

Regardless is there a way to post the messages to the console tty1 ..
without having to resort to the lilo prompt .. and telling it
console=??..

also how do i log to multiple consoles .. or send only certain types of
messages .. based on the user/author of the message or content of the
message to different ttys?

Its late.. i should know this ... help


Thanks bunches in advance

Madhav


Note: The information contained in this message may be privileged and confidential and protected from disclosure.  If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer.  Thank you.  Wagner Weber & Williams
