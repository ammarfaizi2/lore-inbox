Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbTLMOEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 09:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTLMOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 09:04:24 -0500
Received: from mx.laposte.net ([81.255.54.11]:36039 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S265058AbTLMOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 09:04:23 -0500
Subject: Re: No VT console on 2.6.0-test11
From: Frederik Deweerdt <frederik.deweerdt@laposte.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3FD87C40.9040803@blueyonder.co.uk>
References: <3FD87C40.9040803@blueyonder.co.uk>
Content-Type: text/plain
Message-Id: <1071323998.5413.5.camel@silenus.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Dec 2003 14:59:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vga=normal in order to see the bootup messages, looks like a FB bug.
Not sure its a bug, I though that the vga= interface may just have 
changed. You may want to have a look at Documenation/svga.txt, but in
short, vga=ask and then vga=<mode # you've choosen> should suffice. 
Regards,
Fred


