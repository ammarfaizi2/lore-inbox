Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbQL0Rkg>; Wed, 27 Dec 2000 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbQL0Rk0>; Wed, 27 Dec 2000 12:40:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30736 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130612AbQL0RkV>; Wed, 27 Dec 2000 12:40:21 -0500
Date: Wed, 27 Dec 2000 13:16:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Dave Gilbert <gilbertd@treblig.org>
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <m3d7eeb1pa.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Dec 2000, Christoph Rohland wrote:

> Hi Linus,
> 
> The following patchlet bring the handling of shmget with size zero
> back to the 2.2 behaviour. There seem to be programs out, which
> (erroneously) rely on this.

Just curiosity: do you know if any specification (POSIX?) defines this
behaviour? 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
