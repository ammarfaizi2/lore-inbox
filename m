Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbQJ3XFc>; Mon, 30 Oct 2000 18:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbQJ3XFW>; Mon, 30 Oct 2000 18:05:22 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57358 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129290AbQJ3XFE>;
	Mon, 30 Oct 2000 18:05:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 18:02:34 CDT."
             <39FDFE0A.BB9691E6@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 10:04:59 +1100
Message-ID: <11563.972947099@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 18:02:34 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>As an aside:  remember you mentioned we should try to go 100% OX_OBJS
>anyway, eliminating O_OBJS completely...

That is a global change for 2.5, it would massively break 2.4 kbuild.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
