Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFM32>; Mon, 6 Nov 2000 07:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129203AbQKFM3S>; Mon, 6 Nov 2000 07:29:18 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:60431 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129044AbQKFM3O>;
	Mon, 6 Nov 2000 07:29:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Your message of "Mon, 06 Nov 2000 07:13:07 CDT."
             <3A06A053.56F09ACB@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 23:29:07 +1100
Message-ID: <2908.973513747@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000 07:13:07 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>...or, give up this silly nonsense about loading and unload modules on
>every open() and close().   A module load modifies the running kernel
>code... why do people do this on such a whim?
>
>Just load the driver at bootup and forget about it.  Problem solved.

I daily curse the name of whoever added autoload and autounload.
Autoload maybe useful, autounload is just asking for problems.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
