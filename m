Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQKFAFw>; Sun, 5 Nov 2000 19:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKFAFn>; Sun, 5 Nov 2000 19:05:43 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:57371 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129110AbQKFAFa>; Sun, 5 Nov 2000 19:05:30 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ryan <ryan@netidea.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP) 
In-Reply-To: Your message of "Sun, 05 Nov 2000 13:08:41 -0800."
             <3A05CC59.7B0566C7@netidea.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 11:04:06 +1100
Message-ID: <1459.973469046@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Nov 2000 13:08:41 -0800, 
ryan <ryan@netidea.com> wrote:
>Kernel oops. A message like:
>
>"Detected LOCKUP on CPU0"
>or sometimes its CPU1...

Which tells us precisely nothing.  Saying "a message like" is no good.
You need to follow the procedure in linux/REPORTING-BUGS, including the
_exact_ message, run through ksymoops if necessary.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
