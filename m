Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSHQTU1>; Sat, 17 Aug 2002 15:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSHQTU1>; Sat, 17 Aug 2002 15:20:27 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:13470 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S318145AbSHQTU0>;
	Sat, 17 Aug 2002 15:20:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre3 hangs on boot on Duron/VIA
References: <1a5f.3d5e4a78.902bc@trespassersw.daria.co.uk>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: 17 Aug 2002 12:24:24 -0700
In-Reply-To: <1a5f.3d5e4a78.902bc@trespassersw.daria.co.uk> (message from Jonathan Hudson on Sat, 17 Aug 2002 13:07:04 GMT)
Message-ID: <87adnl2srb.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Hudson <jonathan@daria.co.uk> writes:

> 2.4.20-pre3 hangs on boot on a Duron/VIA system, immediately after
> displaying the line:
> 
>  Initializing RT netlink socket 
> 

same thing on an athlon/via system. kernel was compiled with gcc 2.95
2.4.20-pre2 boots fine.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
