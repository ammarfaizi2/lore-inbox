Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSAMSu1>; Sun, 13 Jan 2002 13:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287656AbSAMSuR>; Sun, 13 Jan 2002 13:50:17 -0500
Received: from ns.ithnet.com ([217.64.64.10]:64007 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287488AbSAMSuG>;
	Sun, 13 Jan 2002 13:50:06 -0500
Date: Sun, 13 Jan 2002 19:49:58 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, anton@samba.org
Subject: Re: [patch] O(1) scheduler, -H7
Message-Id: <20020113194958.62f8f674.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
In-Reply-To: <20020113185732.72ea3aa8.skraw@ithnet.com>
	<Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 20:58:12 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> On Sun, 13 Jan 2002, Stephan von Krawczynski wrote:
> 
> > sched.o sched.c sched.c:21: asm/sched.h: No such file or directory
> 
> Please re-download the 2.4.17 -H7 patch, i've fixed this.

Ok, I tried on top of vanilla 2.4.17 and it works.

Seems like 2.4.18-pre3 and H7 don't like each other :-)

Regards,
Stephan


