Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131835AbQKJXBs>; Fri, 10 Nov 2000 18:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132136AbQKJXBi>; Fri, 10 Nov 2000 18:01:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131835AbQKJXBZ>; Fri, 10 Nov 2000 18:01:25 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Date: 10 Nov 2000 15:01:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhuno$bdp$1@cesium.transmeta.com>
In-Reply-To: <3A0C6E01.EFA10590@timpanogas.org> <Pine.LNX.4.21.0011101450060.11307-100000@dlang.diginsite.com> <20001110142547.F16213@sendmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001110142547.F16213@sendmail.com>
By author:    Claus Assmann <sendmail+ca@sendmail.org>
In newsgroup: linux.dev.kernel
> 
> Why does Linux report a LA of 10 if there are only two processes
> running?
> 

Load Average = runnable processes (R) + processes in disk wait (D).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
