Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQLFMIP>; Wed, 6 Dec 2000 07:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130696AbQLFMIG>; Wed, 6 Dec 2000 07:08:06 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:29702
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129703AbQLFMH5>; Wed, 6 Dec 2000 07:07:57 -0500
Date: Wed, 6 Dec 2000 06:47:32 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
Message-ID: <20001206064732.A6542@animx.eu.org>
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, Dec 05, 2000 at 11:25:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - pre6:
>     - Andrew Morton: exec_usermodehelper fixes

pre4 oopsed all over the place on my alpha with modules and autoloading
turned on as soon as it mounted / and freed unused memory.  I take it this
was seen on i386 as well?

Will try pre6.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
