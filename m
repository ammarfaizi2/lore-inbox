Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbREPUmW>; Wed, 16 May 2001 16:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262086AbREPUmM>; Wed, 16 May 2001 16:42:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262085AbREPUmC>; Wed, 16 May 2001 16:42:02 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: chip@valinux.com (Chip Salzenberg)
Date: Wed, 16 May 2001 21:37:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <20010515163923.P3098@valinux.com> from "Chip Salzenberg" at May 15, 2001 04:39:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15083L-0004Bj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't mean to suggest that ioctls be used to deduce device types
> (except in the case of overlapping ioctl numbers, which shouldn't be
> all *that* common (I hope)).  I mean to suggest that the question
> "What device type are you?" usually shouldn't even be asked!

But people need to ask it. Sometimes it really matters. It doesnt have to be
in your face as /dev/hda1 versus /dev/sda1 is but it has to be possible

