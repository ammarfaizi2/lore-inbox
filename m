Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276166AbRI1Qt7>; Fri, 28 Sep 2001 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276164AbRI1Qtt>; Fri, 28 Sep 2001 12:49:49 -0400
Received: from web20401.mail.yahoo.com ([216.136.226.120]:23055 "HELO
	web20401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276165AbRI1Qtk>; Fri, 28 Sep 2001 12:49:40 -0400
Message-ID: <20010928165004.3060.qmail@web20401.mail.yahoo.com>
Date: Fri, 28 Sep 2001 09:50:04 -0700 (PDT)
From: Anil Kumar <kernelmack@yahoo.com>
Subject: putting a user program to sleep till interrupted
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200109281530.f8SFUbN18754@ns.caldera.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I wanted to know how a user program/process can be put
to sleep by using the functions given in the kernel. I
will be calling the function not from user space but
from kernel space, i.e. from inside the kernel. I also
want to be able to start it again whenever required.
I went thru sched.c but couldn't figure out how to
make my own wait list.
Thanx in advance.
Anil

__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
