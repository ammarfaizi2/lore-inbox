Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMC1K>; Sun, 12 Nov 2000 21:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKMC1A>; Sun, 12 Nov 2000 21:27:00 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:61507 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129103AbQKMC0o>; Sun, 12 Nov 2000 21:26:44 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: tytso@mit.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3) 
In-Reply-To: Your message of "Sun, 12 Nov 2000 14:39:09 CDT."
             <200011121939.eACJd9D01319@trampoline.thunk.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 13:26:29 +1100
Message-ID: <1835.974082389@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2000 14:39:09 -0500, 
tytso@mit.edu wrote:
>6. In Progress
>     * DRM and MTD cannot use AGP support module when CONFIG_MODVERSIONS
>       is defined (issue with get_module_symbol caused fix proposed by
>       John Levon to be rejected) (Keith Owens has fix)

Fix included in 2.4.0-test11-pre1.  I have seen no problems, apart from
dwwm who wants the interface backported to 2.2, but that is a separate
issue.

>8. Fix Exists But Isnt Merged
>     * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
>       (Keith Owens)

Fix (by whom?) included in 2.4.0-test11-pre3.  Looks good.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
