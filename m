Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135607AbRDSUPE>; Thu, 19 Apr 2001 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135674AbRDSUOu>; Thu, 19 Apr 2001 16:14:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135607AbRDSUOb>; Thu, 19 Apr 2001 16:14:31 -0400
Subject: Re: light weight user level semaphores
To: drepper@cygnus.com
Date: Thu, 19 Apr 2001 21:11:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        abramo@alsa-project.org (Abramo Bagnara), alonz@nolaviz.org (Alon Ziv),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mkravetz@sequent.com (Mike Kravetz)
In-Reply-To: <m3lmow1woa.fsf@otr.mynet.cygnus.com> from "Ulrich Drepper" at Apr 19, 2001 01:06:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qKlf-0007y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't want nor need file permissions.  A program would look like this:

Your example opens/mmaps so has file permissions. Which is what I was asking

> The shared mem segment can be retrieved in whatever way.  The mutex in
> this case is anonymous.  Everybody who has access to the shared mem
> *must* have access to the mutex.

We agree 8)

