Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBIDQC>; Thu, 8 Feb 2001 22:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBIDPw>; Thu, 8 Feb 2001 22:15:52 -0500
Received: from [200.222.195.14] ([200.222.195.14]:21393 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129032AbRBIDPr>; Thu, 8 Feb 2001 22:15:47 -0500
Date: Fri, 9 Feb 2001 01:14:13 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Jochen Striepe <jochen@tolot.escape.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modify ver_linux to check e2fsprogs and more.
Message-ID: <20010209011413.Q1922@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Striepe wrote:

> tolot:/root # hostname --version
> hostname (GNU sh-utils) 2.0.11
> Written by Jim Meyering.

AFAIK, all distributions use hostname from net-tools, not from
sh-utils.

% hostname -V
net-tools 1.57
hostname 1.99 (2000-02-13)

Why duplicate it (on Linux) ?

-- 
Frédéric L. W. Meunier - http://www.pervalidus.net/
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
