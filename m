Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRA3BAt>; Mon, 29 Jan 2001 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbRA3BAj>; Mon, 29 Jan 2001 20:00:39 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25421 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130882AbRA3BAZ>; Mon, 29 Jan 2001 20:00:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: Matthew Pitts <mpitts@suite224.net>, Jacob Anawalt <anawaltaj@qwest.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with 
In-Reply-To: Your message of "Mon, 29 Jan 2001 12:41:31 -0800."
             <4461B4112BDB2A4FB5635DE1995874320223F3@mail0.myrio.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 12:00:16 +1100
Message-ID: <26703.980816416@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001 12:41:31 -0800, 
Torrey Hoffman <torrey.hoffman@myrio.com> wrote:
>Should someone submit a patch to copy the .config to a standard location as
>part of "make install" or "make modules_install"? If included in the
>official sources, that good example would encourage the distribution
>maintainers do the same. 

Not until FHS decide what that standard location is.  An entry in FHS
will carry far more weight with distributors than a kernel Makefile
patch.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
