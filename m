Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130453AbQKYWAS>; Sat, 25 Nov 2000 17:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131060AbQKYWAI>; Sat, 25 Nov 2000 17:00:08 -0500
Received: from hera.cwi.nl ([192.16.191.1]:56564 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S130453AbQKYV7y>;
        Sat, 25 Nov 2000 16:59:54 -0500
Date: Sat, 25 Nov 2000 22:29:44 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: rusty@linuxcare.com.au, tigran@veritas.com, linux-kernel@vger.kernel.org,
        Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001125222944.B6919@veritas.com>
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252107.VAA02744@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011252107.VAA02744@raistlin.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Nov 25, 2000 at 09:07:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 09:07:08PM +0000, Russell King wrote:
> Andries Brouwer writes:
> > What a strange reaction. If I write
> > 
> >  static int foo;
> > 
> > this means that foo is a variable, local to the present compilation unit,
> > whose initial value is irrelevant 
> 
> Wrong.  The initial value is well-defined.

Oh, please - something is wrong with your reading comprehension.
Don't you understand the word "irrelevant"? It means that the
initial value does not matter. It does not mean undefined.
Please reread my letter and comment when you understand my point.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
