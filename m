Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290506AbSAYQac>; Fri, 25 Jan 2002 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290715AbSAYQaW>; Fri, 25 Jan 2002 11:30:22 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:61199 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S290506AbSAYQaQ>; Fri, 25 Jan 2002 11:30:16 -0500
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jan 2002 06:31:10 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <3C50FBAE.26883.8EF8C@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a module and would like to perform arithmetic on long 
long variables. When I try to do this the module does not load due
to the unresolved symbols __udivdi3 and __umoddi3. I notice these
are normally defined in libc. Is there any way I can do this in a 
kernel module.

Many Thanks

Simon.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
