Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271823AbRHUS4u>; Tue, 21 Aug 2001 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271824AbRHUS4a>; Tue, 21 Aug 2001 14:56:30 -0400
Received: from beppo.feral.com ([192.67.166.79]:524 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S271823AbRHUS4X>;
	Tue, 21 Aug 2001 14:56:23 -0400
Date: Tue, 21 Aug 2001 11:56:12 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jes Sorensen <jes@sunsite.dk>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010821115155.X23686-100000@wonky.feral.com>
Message-ID: <20010821115450.U23686-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Interesting- I should have checked- they didn't use to have GPL on the f/w.
> Earlier driver versions didn't! Oops!
>

Actually, it's not quite. The 2200 f/w has:

/************************************************************************
 *                                                                      *
 *               --- ISP2200 Initiator/Target Firmware ---              *
 *             with Fabric (Public Loop), Point-point, and              *
 *             expanded LUN addressing for FCTAPE                       *
 *                                                                      *
 ************************************************************************
  Copyright (C) 2000 and 2100 Qlogic Corporation
  (www.qlogic.com)

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.
*******************************************************************
/*
 *      Firmware Version 2.01.27 (11:07 Dec 18, 2000)
 */

(you should  note, btw, that the f/w that's on the internal QLogic website for
OEMS is 2.1.26)

So, it's *sort of* GPLd....

-matt


