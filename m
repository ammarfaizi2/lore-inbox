Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKTQm>; Mon, 11 Dec 2000 14:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQLKTQd>; Mon, 11 Dec 2000 14:16:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42766 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbQLKTQT>; Mon, 11 Dec 2000 14:16:19 -0500
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 11 Dec 2000 18:46:32 +0000 (GMT)
Cc: vii@penguinpowered.com (John Fremlin), scole@lanl.gov,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012111636040.4808-100000@duckman.distro.conectiva> from "Rik van Riel" at Dec 11, 2000 04:38:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145Xy6-0008HA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
> for the VM doesn't make any sense since it doesn't really excercise
> the VM in any way...

Its an interesting demo that 2.4 has some performance problems since 2.2
is slower than 2.0 although nowdays not much.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
