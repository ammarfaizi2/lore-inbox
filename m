Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbQKTSBK>; Mon, 20 Nov 2000 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQKTSBA>; Mon, 20 Nov 2000 13:01:00 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:4083 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129792AbQKTSAu>; Mon, 20 Nov 2000 13:00:50 -0500
Date: Mon, 20 Nov 2000 15:30:20 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Steven_Snyder@3com.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Any advantage to kernel 2.4 in low-end system?
In-Reply-To: <8825699D.005FFF54.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.4.21.0011201529340.4587-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000 Steven_Snyder@3com.com wrote:

> In reading about the cool new features of Linux v2.4, most of
> the improvements/changes seem to relate to high-end systems.  
> Would users of low-end systems (386/486, low memory, etc.) be
> advised to stay with kernel v2.2.x or is v2.4.x the way to go
> for these systems as well?

The memory management in 2.4 should be quite a bit
better for systems where the working set size is
more than a tiny fraction of system memory ;)

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
