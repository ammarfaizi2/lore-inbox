Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSGOSey>; Mon, 15 Jul 2002 14:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317581AbSGOSex>; Mon, 15 Jul 2002 14:34:53 -0400
Received: from web14205.mail.yahoo.com ([216.136.172.151]:8866 "HELO
	web14205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317580AbSGOSev>; Mon, 15 Jul 2002 14:34:51 -0400
Message-ID: <20020715183746.72137.qmail@web14205.mail.yahoo.com>
Date: Mon, 15 Jul 2002 20:37:46 +0200 (CEST)
From: =?iso-8859-1?q?Miguel=20Rodr=EDguez?= <agus_081074@yahoo.com>
Subject: patchless debugger for U.P x86
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have released an initial alpha release for a x86
(uniprocessor) Linux kernel patchless debugger under
the GNU GPL at savannah.gnu.org. Project is called
kmdbg. First debugger implemented is a remote serial
debugger.
It is just a simple interrupt/exception/syscall
interception scheleton and may have a lot of errors
(or not work at all) although it worked for me with
kernel 2.4.XX, 2.5.24.
See:

https://savannah.gnu.org/projects/kmdbg

Miguel.


_______________________________________________________________
Yahoo! Messenger
Nueva versión: Webcam, voz, y mucho más ¡Gratis! 
Descárgalo ya desde http://messenger.yahoo.es
