Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbRFYPgy>; Mon, 25 Jun 2001 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbRFYPgo>; Mon, 25 Jun 2001 11:36:44 -0400
Received: from patan.Sun.COM ([192.18.98.43]:4569 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S264631AbRFYPg3>;
	Mon, 25 Jun 2001 11:36:29 -0400
Message-ID: <3B375A77.C59A516D@Sun.COM>
Date: Mon, 25 Jun 2001 17:36:23 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Fork vs GDB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Does anyone knows how to debug a program which fork. It seems that gdb
doesn't allow us to debug the child processes without calling 'sleep' in
the child, and attach it to gdb (Except on HP-UX, but I choose to use
Linux ;-)) ?

Tnx. 
--

    Julien Laganier
     Student Intern
Sun Microsystem Laboratories
