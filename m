Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTIJFwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbTIJFws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:52:48 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:10625
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264672AbTIJFwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:52:46 -0400
Date: Wed, 10 Sep 2003 01:52:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Muthukumar <kmuthukumar@mail15.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem on linux-kernel-2.6.0-test3
In-Reply-To: <200309100509.h8A591O4087507@www.mail15.com>
Message-ID: <Pine.LNX.4.53.0309100151020.14426@montezuma.fsmlabs.com>
References: <200309100509.h8A591O4087507@www.mail15.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Muthukumar wrote:

> Hello all ,
> 
> I am muthukumar working in squid development ,for the developmet in 
> epoll,i have tried to compile the kernel-2.6 with IA64 support on 
> IA64 platform.
> 
> But in the compilation i am getting the error as 
> 
> HOSTCC  scripts/lxdialog/checklist.o
> In file included from scripts/lxdialog/checklist.c:24:
> scripts/lxdialog/dialog.h:29:20: curses.h: No such file or 
> directory
> In file included from scripts/lxdialog/checklist.c:24:
> scripts/lxdialog/dialog.h:127: error: parse error before 
> "use_colors"

You will need to install ncurses/ncurses-devel.

