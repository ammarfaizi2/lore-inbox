Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSCHXXy>; Fri, 8 Mar 2002 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCHXXl>; Fri, 8 Mar 2002 18:23:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289606AbSCHXXg>; Fri, 8 Mar 2002 18:23:36 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: frankeh@watson.ibm.com
Date: Fri, 8 Mar 2002 23:38:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <20020308225425.772D13FE06@smtp.linux.ibm.com> from "Hubertus Franke" at Mar 08, 2002 05:55:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jTwo-0007y1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NO and let me explain.
> 
> I would to be able to integrate the lock with the data.
> This is much more cache friendly then putting the lock on a different 
> cacheline.

Yep - I agree
