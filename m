Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316330AbSEQQ0C>; Fri, 17 May 2002 12:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSEQQ0B>; Fri, 17 May 2002 12:26:01 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:64671 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316330AbSEQQ0A>;
	Fri, 17 May 2002 12:26:00 -0400
Date: Fri, 17 May 2002 18:25:42 +0200
From: "'Roger Luethi'" <rl@hellgate.ch>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020517162542.GB1175@k3.hellgate.ch>
In-Reply-To: <20020517001534.GA3632@k3.hellgate.ch> <Pine.LNX.3.95.1020517084216.4475A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, maybe the fashion of the day. Do `grep karound *.c` in
> ../linux/drivers/net and see all the 'workarounds' that exist for
> chip problems. Some of the problems are induced by the coding and
> most are real hardware problems.

Nobody's debating the need for workarounds. I just prefer to look for a
more subtle method before taking out the sledge-hammer several times a
second(!) to reprogram the chip from scratch.

Roger
