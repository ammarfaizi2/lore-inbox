Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288705AbSADR7p>; Fri, 4 Jan 2002 12:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288704AbSADR7f>; Fri, 4 Jan 2002 12:59:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65418 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288702AbSADR70>;
	Fri, 4 Jan 2002 12:59:26 -0500
Date: Fri, 4 Jan 2002 20:56:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
In-Reply-To: <20020104173851.GA3027@spylog.ru>
Message-ID: <Pine.LNX.4.33.0201042056150.11338-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Andrey Nekrasov wrote:

> ipconfig.c: In function `ip_auto_config':
> ipconfig.c:1148: `UNNAMED_MAJOR' undeclared (first use in this function)
> ipconfig.c:1148: (Each undeclared identifier is reported only once
> ipconfig.c:1148: for each function it appears in.)

> ps. vanilla kernel compile ok.

hm, the patch does not change ipconfig.c.

	Ingo

