Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAEPIw>; Fri, 5 Jan 2001 10:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAEPId>; Fri, 5 Jan 2001 10:08:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129718AbRAEPIW>; Fri, 5 Jan 2001 10:08:22 -0500
Subject: Re: 2.4 todo list update
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 5 Jan 2001 15:10:18 +0000 (GMT)
Cc: tytso@MIT.EDU (Theodore Y. Ts'o), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101051244440.1295-100000@duckman.distro.conectiva> from "Rik van Riel" at Jan 05, 2001 12:58:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EYVa-0007oG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * VFS?VM - mmap/write deadlock (demo code seems to show lock
>   is there)

Linus fixed that.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
