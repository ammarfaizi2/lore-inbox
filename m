Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130867AbQKGPYr>; Tue, 7 Nov 2000 10:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130865AbQKGPYh>; Tue, 7 Nov 2000 10:24:37 -0500
Received: from [193.127.21.194] ([193.127.21.194]:29754 "HELO
	postal.sl.trymedia.com") by vger.kernel.org with SMTP
	id <S130543AbQKGPY3>; Tue, 7 Nov 2000 10:24:29 -0500
From: Abel Muñoz Alcaraz <abel@trymedia.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: A question about memory fragmentation
Date: Tue, 7 Nov 2000 16:20:20 +0100
Message-ID: <CAEBJLAGJIDLDINHENLOGEMOCGAA.abel@trymedia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
	I have a question for you; How Linux avoids the memory fragmentation in
linked lists?

	Windows 9x/NT/2000 (sorry, ;-)), have specific functions (like List_Create,
ExInitializeSListHead, ...) to create generic linked lists but I don't find
something similar in Linux.
	Has Linux a generic linked list management API ?
	Must I develop this?
	Is the kernel memory fragmentation a solved problem in Linux? (I wish it).

	I have develop my own API but I don't know if Linux can do this for me.

Thanks in advance.

Abel Muñoz Alcaraz.
Media Security Software Developer.
mailto:abel@trymedia.com
Trymedia Systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
