Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHLJya>; Mon, 12 Aug 2002 05:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSHLJya>; Mon, 12 Aug 2002 05:54:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:38149 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317637AbSHLJy3>; Mon, 12 Aug 2002 05:54:29 -0400
Message-ID: <3D578713.42ED8BA0@aitel.hist.no>
Date: Mon, 12 Aug 2002 11:59:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.31
References: <200208100551.46142.ivangurdiev@attbi.com.suse.lists.linux.kernel> <p73r8h5itu7.fsf@oldwotan.suse.de> <20020811113418.A29786@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
[...]
> > make oldconfig and recompiling should fix that.
> 
> Hmm, is it time to make .config depend on arch/$(ARCH)/config.in and all
> Config.in files?

And perhaps the makefile, so a new kernel revision forces
a "make oldconfig" all by itself.

Helge Hafting
