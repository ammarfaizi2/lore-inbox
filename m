Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSACQA1>; Thu, 3 Jan 2002 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287351AbSACQAQ>; Thu, 3 Jan 2002 11:00:16 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59653 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S287348AbSACQAI>;
	Thu, 3 Jan 2002 11:00:08 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201031554.g03Fsm206277@saturn.cs.uml.edu>
Subject: Re: system.map
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 3 Jan 2002 10:54:48 -0500 (EST)
Cc: tmh@nothing-on.tv (Tony Hoyle), timothy.covell@ashavan.org,
        adriankok2000@yahoo.com.hk (adrian kok), linux-kernel@vger.kernel.org
In-Reply-To: <E16LxOr-000118-00@starship.berlin> from "Daniel Phillips" at Jan 03, 2002 03:14:29 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

>    cp arch/i386/boot/bzImage /boot/bzImage-$kernel
>    cp System.map /boot/System.map-$kernel
>    cp .config /boot/config-$kernel

Gee, exactly the names I use. Surely then, this is correct.
You even take the '.' off of .config like I do. The only
difference is that you don't keep a copy of vmlinuz as well.

For a Mac, the only difference is that you need vmlinuz and
there isn't any bzImage at all. Stuff still goes in /boot.
(plus ybin and yaboot.conf instead of lilo and lilo.conf)
