Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbTCQSJu>; Mon, 17 Mar 2003 13:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCQSJu>; Mon, 17 Mar 2003 13:09:50 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:46976 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261816AbTCQSJt>; Mon, 17 Mar 2003 13:09:49 -0500
Date: Mon, 17 Mar 2003 19:20:40 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: re: Ptrace hole / Linux 2.2.25
Message-ID: <20030317182040.GA2145@louise.pinerecords.com>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com> <1047923841.1600.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047923841.1600.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [arjanv@redhat.com]
> 
> I've attached a patch against 2.4.21pre5.

So what happens now?

Is this critical enough for 2.4.21 to go out?  Or can it wait like
some other fairly serious stuff such as the ext3 fixes?  What about
the current state of IDE?

Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
or 2.4.20.1 with only the critical stuff applied?

-- 
Tomas Szepe <szepe@pinerecords.com>
