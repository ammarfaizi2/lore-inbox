Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTAWLmQ>; Thu, 23 Jan 2003 06:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTAWLmQ>; Thu, 23 Jan 2003 06:42:16 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27140 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265134AbTAWLmP>;
	Thu, 23 Jan 2003 06:42:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301231150.h0NBoVAV000396@darkstar.example.net>
Subject: Re: new kernel fail
To: yaomf@gdufs.edu.cn (Yao Minfeng)
Date: Thu, 23 Jan 2003 11:50:31 +0000 (GMT)
Cc: kernel@ketil.froyn.name, linux-kernel@vger.kernel.org
In-Reply-To: <002201c2c2d4$612c8c80$81df74ca@hammer> from "Yao Minfeng" at Jan 23, 2003 07:41:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using ext3 for 2.4.7-10, but during the kernel configuration, I can't
> find the option to include ext3, any suggestions?

EXT-3 was not introduced until 2.4.15.

By the way, why not just try the latest 2.4 tree, 2.4.20?  If you have
any problems with 2.4.12, or 2.4.16, the first thing that will
probably be suggested will be to try 2.4.20.

John.
