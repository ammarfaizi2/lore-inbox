Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268210AbTBNVQ2>; Fri, 14 Feb 2003 16:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTBNVPy>; Fri, 14 Feb 2003 16:15:54 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:2052 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id <S268210AbTBNVOw>;
	Fri, 14 Feb 2003 16:14:52 -0500
Date: Fri, 14 Feb 2003 22:24:45 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: creating incremental diffs
In-Reply-To: <20030214210754.GN20159@fs.tum.de>
Message-ID: <Pine.LNX.4.51.0302142222400.18666@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
 <20030214210754.GN20159@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   interdiff -z 2.4.21pre4aa1.gz 2.4.21pre4aa2.gz > my-aa1-aa2
Ok, works great.

But the patches created by interdiff and the method proposed by Joshua
are different :)
5kb of differences. Intriguing.


Regards,
Maciej


