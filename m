Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275992AbRI1JPE>; Fri, 28 Sep 2001 05:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275986AbRI1JOy>; Fri, 28 Sep 2001 05:14:54 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:63637 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S275985AbRI1JOo>;
	Fri, 28 Sep 2001 05:14:44 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15284.16283.111942.13934@harpo.it.uu.se>
Date: Fri, 28 Sep 2001 11:15:07 +0200
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
In-Reply-To: <20010927234023.A16753@devserv.devel.redhat.com>
In-Reply-To: <200109042234.AAA28635@harpo.it.uu.se>
	<20010927234023.A16753@devserv.devel.redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:
 > By the way, why does everyone insist on using ide-tape?
 > It seems to be broken beyond any repair by injection of
 > lethal poison marked "OnStream Support" (not that it was brilliant
 > before, but that was the last nail in the coffin). Just use ide-scsi
 > and be done with it. I really do not enjoy reading ide-tape.c.

I agree that ide-tape.c looks like a buggy piece of cr*p, but apart
from that, what would I gain from using scsi tape on top of ide-scsi?
Would it magically work on broken Colorados?

/Mikael
