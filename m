Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKTMV>; Mon, 11 Dec 2000 14:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLKTML>; Mon, 11 Dec 2000 14:12:11 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:5623 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129183AbQLKTMJ>; Mon, 11 Dec 2000 14:12:09 -0500
Date: Mon, 11 Dec 2000 16:38:11 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: John Fremlin <vii@penguinpowered.com>
cc: scole@lanl.gov, linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <m2k896rfg4.fsf@localhost.yi.org.>
Message-ID: <Pine.LNX.4.21.0012111636040.4808-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2000, John Fremlin wrote:

> Two points: 		[snipped]


Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
for the VM doesn't make any sense since it doesn't really excercise
the VM in any way...

If you want to measure, or even just bitch about, the VM, you should
at least quote results from something that uses the VM ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
