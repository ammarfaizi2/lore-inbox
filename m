Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSIISMx>; Mon, 9 Sep 2002 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSIISMw>; Mon, 9 Sep 2002 14:12:52 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:32018 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S318741AbSIISMc>;
	Mon, 9 Sep 2002 14:12:32 -0400
Date: Mon, 9 Sep 2002 12:16:28 -0600 (MDT)
From: Kurt Ferreira <kurdt@nmt.edu>
To: linux-kernel@vger.kernel.org
cc: Imran Badr <imran.badr@cavium.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: RE: Calculating kernel logical address ..
In-Reply-To: <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0209091212540.2275-100000@eldorado.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Richard B. Johnson wrote:

> Well I just read Documentation/DMA-mapping.txt as advised by David
> and it seems as though it will no longer be possible to do what
> many programmers have been wanting to do, to wit:
>
> (1) In user-code, allocate a buffer.
> (2) Lock that buffer into memory.
> (3) Call some driver that DMAs data to/from that buffer.
>
Hmm.  IIRC (big if) did not kiobufs allow something similar to this.  It
has been long since I have looked though.

Kurt

