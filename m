Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271757AbRH0PlV>; Mon, 27 Aug 2001 11:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271762AbRH0PlL>; Mon, 27 Aug 2001 11:41:11 -0400
Received: from [212.93.134.61] ([212.93.134.61]:13842 "EHLO zebra.sibnet.ro")
	by vger.kernel.org with ESMTP id <S271757AbRH0PlB>;
	Mon, 27 Aug 2001 11:41:01 -0400
Date: Mon, 27 Aug 2001 18:51:49 -0400 (EDT)
From: <sacx@zebra.sibnet.ro>
To: <linux-kernel@vger.kernel.org>
Subject: module
Message-ID: <Pine.LNX.4.33L2.0108271826510.32587-100000@zebra.sibnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I'm trying to comunicate some parameters from kernel to a module.
	I define a new function somwhere in kernel and after rebuilding
the version of my function is something like :

c027b7f0 function_R__ver_function (# cat /proc/ksyms | grep function)
(somewhere in *.ver files I can see the correct version)
And if I want to insert my module in kernel I get an error :
func.o: unresolved symbol function (because of the wrong function version)

Something is wrong, but I don't know what ...

You can help me ?

Best Regards
Adrian Stanila

P.S. I'm a newbie in kernel hacking and I don't want to disturb you but
if you can help me ... please answer to my email :)))


