Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbREUSoQ>; Mon, 21 May 2001 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbREUSoG>; Mon, 21 May 2001 14:44:06 -0400
Received: from pop.gmx.net ([194.221.183.20]:54697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261238AbREUSoD>;
	Mon, 21 May 2001 14:44:03 -0400
Message-ID: <3B0963AF.FDCB8AA2@gmx.at>
Date: Mon, 21 May 2001 20:51:27 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Vojta <vojta@ipex.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
In-Reply-To: <20010521090946.D769@ipex.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Vojta wrote:
> 
> Hi,
>   I have this card in intranet server and I'm very confused about very often
> message in log like this:
> 
> eth0: Transmit error, Tx status register 82.
>   Flags; bus-master 1, dirty 20979238(6) current 20979242(10)
>   Transmit list 1f659290 vs. df659260.
>   0: @df659200  length 800005ea status 000105ea
>   1: @df659210  length 80000296 status 00010296
>   2: @df659220  length 800005ea status 000105ea
[snip]

Hi,

I had the same problem with 2.4.3-pre6 (also with the 3c905C). Alle
problems were gone with 2.4.4, so I stopped bothering. Hope this
helps...

Wilfried
