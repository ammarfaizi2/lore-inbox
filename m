Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbRFZAjf>; Mon, 25 Jun 2001 20:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264710AbRFZAjZ>; Mon, 25 Jun 2001 20:39:25 -0400
Received: from web10405.mail.yahoo.com ([216.136.130.97]:16650 "HELO
	web10405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264688AbRFZAjF>; Mon, 25 Jun 2001 20:39:05 -0400
Message-ID: <20010626003904.65704.qmail@web10405.mail.yahoo.com>
Date: Tue, 26 Jun 2001 10:39:04 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Hang with usb scanner...2.4.5-acx
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

I got scanner epson perfection 640u. I am not sure if
it is a bug or I have to do like that.

Basically I have to compile scanner support as module
and uhci as well. Whenever I need to scan, just turn
on, modprobe ...; it is fine. When no need, remove
modules and turn off.

BUT if i compile built in to th kernel. the system
hang in sush cases:

- turn on pc, start everything, then turn on scanner

- turn on scanner then turn on pc start everything,
scanner works ; now turn off scanner

No messages in /var/log ; just hang all key board wont
work, can not login from remote, ; have to unplug the
power

thanks,




=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
