Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTBDUPg>; Tue, 4 Feb 2003 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbTBDUPg>; Tue, 4 Feb 2003 15:15:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:31241 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267436AbTBDUPf>;
	Tue, 4 Feb 2003 15:15:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302042020.h14KK6oV002837@darkstar.example.net>
Subject: Re: gcc 2.95 vs 3.21 performance
To: john@grabjohn.com (John Bradford)
Date: Tue, 4 Feb 2003 20:20:06 +0000 (GMT)
Cc: davej@codemonkey.org.uk, wookie@osdl.org,
       vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <200302042011.h14KBuG6002791@darkstar.example.net> from "John Bradford" at Feb 04, 2003 08:11:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that last post didn't make sense, please apply this diff:

- just to create one which compiles the kernel so it runs faster, as the
+ just to create one which compiles the kernel so it runs faster, at the
  expense of other code.

John.
