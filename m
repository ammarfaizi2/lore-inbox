Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136354AbREIMan>; Wed, 9 May 2001 08:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136361AbREIMad>; Wed, 9 May 2001 08:30:33 -0400
Received: from [195.6.125.97] ([195.6.125.97]:15372 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S136354AbREIMaS>;
	Wed, 9 May 2001 08:30:18 -0400
Date: Wed, 9 May 2001 14:28:16 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: signal
Message-Id: <20010509142816.2af8bbbd.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm trying to send signal from a kernel module to an user prog.
(is it possible ?)

But I've found two ways : kill() or sys_kill().

what is the best way ??

Thanks

sebastien person
