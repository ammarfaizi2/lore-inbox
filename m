Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTATQji>; Mon, 20 Jan 2003 11:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTATQji>; Mon, 20 Jan 2003 11:39:38 -0500
Received: from [81.2.122.30] ([81.2.122.30]:62469 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266228AbTATQjg>;
	Mon, 20 Jan 2003 11:39:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301201648.h0KGmt41005782@darkstar.example.net>
Subject: Re: Intel C++ compiler?
To: peter900000@hotmail.com (Henrik Andersen)
Date: Mon, 20 Jan 2003 16:48:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0h6p3$958$1@main.gmane.org> from "Henrik Andersen" at Jan 20, 2003 05:07:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does Intels C++ compiler for Linux works fine for compiling the Linux
> kernel? It is not 100% compatible, as far as I know.

I doubt it - Linux makes extensive use of GCC compiler extensions.

> Which advantages does the Intel compiler brings compared to gcc?
> faster speed? Other things?

In theory it might be slightly faster, however GCC is a fairly good
compiler on i386 anyway.

John.
