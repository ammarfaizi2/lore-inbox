Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132084AbRANVZT>; Sun, 14 Jan 2001 16:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133105AbRANVZK>; Sun, 14 Jan 2001 16:25:10 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:39415 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132084AbRANVYz>; Sun, 14 Jan 2001 16:24:55 -0500
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, david+validemail@kalifornia.com,
        linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <200101132014.f0DKEJh153332@saturn.cs.uml.edu>
	<m3itnih3eb.fsf@linux.local> <20010114134457.A14486@uni-mainz.de>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010114134457.A14486@uni-mainz.de>
Message-ID: <m3r926f0m0.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Jan 2001 22:29:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <dominik.kubla@uni-mainz.de> writes:

> Well, it's tmpfs not only on SUN but for *BSD too.  So i guess we should
> follow the pack and use this name to avoid yet another "it's called this
> under that Unix and this under the other and something else under Linux"
> case.

So does *BSD also have the size parameter?

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
