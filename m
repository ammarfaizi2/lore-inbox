Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291048AbSBLNwE>; Tue, 12 Feb 2002 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291050AbSBLNvz>; Tue, 12 Feb 2002 08:51:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15747 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291048AbSBLNvq>;
	Tue, 12 Feb 2002 08:51:46 -0500
Date: Tue, 12 Feb 2002 05:49:54 -0800 (PST)
Message-Id: <20020212.054954.72712621.davem@redhat.com>
To: bjorn.wesen@axis.com
Cc: zippel@linux-m68k.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1020212135811.18244A-100000@fafner.axis.se>
In-Reply-To: <20020211.165730.59656439.davem@redhat.com>
	<Pine.LNX.3.96.1020212135811.18244A-100000@fafner.axis.se>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bjorn Wesen <bjorn.wesen@axis.com>
   Date: Tue, 12 Feb 2002 14:01:13 +0100 (CET)
   
   We cross-compile all the time and don't have to parse assembler-files,
   just compile a c-file and include the resulting asm into entry.S:

I didn't say "undoable", we were doing it too.  I said ugly,
and what you're showing me isn't pretty :-)
