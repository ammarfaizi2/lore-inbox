Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265915AbRGKDno>; Tue, 10 Jul 2001 23:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266397AbRGKDne>; Tue, 10 Jul 2001 23:43:34 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:11915 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S265915AbRGKDnW>;
	Tue, 10 Jul 2001 23:43:22 -0400
Date: Tue, 10 Jul 2001 20:43:20 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: Nivedita Singhvi <nivedita@sequent.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <200107012127.OAA13394@eng4.sequent.com>
Message-ID: <Pine.LNX.4.33.0107102034410.1135-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if an extra tcp error would have helped me with this.  I
would still have had to learn the details of tcp (acks, delayed acks,
checksum, buffers) in order to learn that a tcp checksum problem could
have produced the behavior I was seeing.

An error notifying me of irq conflicts would have _really_ helped.

Robert.

