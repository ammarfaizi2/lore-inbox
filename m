Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRKIQot>; Fri, 9 Nov 2001 11:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279983AbRKIQoj>; Fri, 9 Nov 2001 11:44:39 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:3505 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S279981AbRKIQob>; Fri, 9 Nov 2001 11:44:31 -0500
Date: Fri, 9 Nov 2001 11:44:28 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Remco Post <r.post@sara.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel. 
In-Reply-To: <200111081000.LAA00436@zhadum.sara.nl>
Message-ID: <Pine.GSO.4.33.0111091139580.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the discussion is irrelevant. Despite what everybody thinks, Linus thinks
>/proc must be not binary, so it will stay that way for those of us who run
>Linus kernels...

Linus has been "wrong" before.  It will require good code and numbers
backing that codes "goodness" before Linus will begin to listen.  Yes,
a new procfs format will break a great deal of userland toys, so the
changes had better be worth it and sufficient to never, EVER require
a complete overhaul in the future.

>I can inmagine people like Alan ignoring this discussion after such a
>statement, the outcome of the discussion is irrelevant for the kernel
>development.

I think Alan is already ignoring the entire discussion.

--Ricky


