Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132594AbQL1Wsc>; Thu, 28 Dec 2000 17:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132593AbQL1WsW>; Thu, 28 Dec 2000 17:48:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12548 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132578AbQL1WsN>; Thu, 28 Dec 2000 17:48:13 -0500
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
To: cr@sap.com (Christoph Rohland)
Date: Thu, 28 Dec 2000 22:19:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), aeb@veritas.com (Andries Brouwer),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        gilbertd@treblig.org (Dave Gilbert)
In-Reply-To: <m3hf3ourke.fsf@linux.local> from "Christoph Rohland" at Dec 28, 2000 11:13:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BlOI-0004MX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can get the Linux special behaviour to be able to attach to a
> removed segment by its shmid by passing the file descriptor for the
> posix shm from the attached process to the attaching process.
> 
> Did I miss something?

Not that I've ever used 8)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
