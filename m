Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271939AbRHVGH6>; Wed, 22 Aug 2001 02:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271940AbRHVGHr>; Wed, 22 Aug 2001 02:07:47 -0400
Received: from [200.222.202.37] ([200.222.202.37]:18824 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S271939AbRHVGHd>; Wed, 22 Aug 2001 02:07:33 -0400
Date: Wed, 22 Aug 2001 03:08:07 -0300
From: =?unknown-8bit?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010822030807.N120@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Mailer: Mutt/1.3.19i - Linux 2.4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I the only one afraid that the Python requirement can turn
into a problem ? You can develop anything on Linux without
Python. I'd compare Python to Tcl - you only install it to
waste space, develop, or run applications that use it. Perl
is very different. It's required by GNU Automake and more.

I'm really surprised by the fact that nobody noticed what a
nightmare 2.6 will be with such a requirement. You can't
expect everybody to install something that's of no use for
most.

My intention isn't to diminish the importance of CML2 and the
hard and volunteer work of Eric S. Raymond. I just can't
consider Python a requirement to configure the build process
of a Kernel.

Please, consider using the actual setup if Python isn't
installed.

PS: I install Python at home to use a single application.
BTW, I compiled Python and... the curses module isn't enabled
by default. You have to edit Setup. Another possible problem
for menuconfig.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
