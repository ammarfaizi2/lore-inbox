Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318588AbSHBK5l>; Fri, 2 Aug 2002 06:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318590AbSHBK5l>; Fri, 2 Aug 2002 06:57:41 -0400
Received: from mail.set-software.de ([193.218.212.121]:23948 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S318588AbSHBK5l> convert rfc822-to-8bit; Fri, 2 Aug 2002 06:57:41 -0400
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 02 Aug 2002 11:01:14 GMT
Message-ID: <20020802.11011405@knigge.local.net>
Subject: Console scrolling in kernel 2.4.xx
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a IGEL Etherminal C Thin Client (that's a "real" computer with 
a Cyrix Media GX CPU, and nearly everything you need on board: LAN, 
ser, par and VGA).

With Linux 2.2.xxx there are no problems, but with Kernels 2.4.xx 
scrolling doesn't work :-((((

If the kernel boots the screen is filled up with kernel-messages. If 
it reached the last line, the screen isn't scrolled up (but booting 
continues - if Linux is up I can telnet to this box).....

Any ideas? How can I help to find the bug (ehem, if it is one)....


Thanks
  Michael




