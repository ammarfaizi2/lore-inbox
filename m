Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTAKQl4>; Sat, 11 Jan 2003 11:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTAKQl4>; Sat, 11 Jan 2003 11:41:56 -0500
Received: from [81.2.122.30] ([81.2.122.30]:13831 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267281AbTAKQlz>;
	Sat, 11 Jan 2003 11:41:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301111647.h0BGlWML004287@darkstar.example.net>
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Sat, 11 Jan 2003 16:47:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301111605.RAA06360@harpo.it.uu.se> from "Mikael Pettersson" at Jan 11, 2003 05:05:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cardbus/hotplugging is still broken in 2.5.56. Inserting a
> card fails due a bogus 'resource conflict', and ejecting it
> oopses the kernel. It's been this way since 2.5.4x-something.

This is a known issue, somebody else reported it to the mailing list
yesterday, and I've put it in my bug db:

http://grabjohn.com/kernelbugdatabase/index.php?action=21&id=18

John.
