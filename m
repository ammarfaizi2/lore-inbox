Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273230AbRINA2p>; Thu, 13 Sep 2001 20:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273236AbRINA2f>; Thu, 13 Sep 2001 20:28:35 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:14464 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S273230AbRINA2X>; Thu, 13 Sep 2001 20:28:23 -0400
Date: Fri, 14 Sep 2001 01:28:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: David Hollister <david@digitalaudioresources.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Conquering the Athlon optimization troubles
In-Reply-To: <3BA1472E.2000008@digitalaudioresources.org>
Message-ID: <Pine.SOL.3.96.1010914012401.21012A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, David Hollister wrote:
> My motherboard is the Epox 8KTA3+, and I'm running an Athlon 1.4GHz.
> 
> Epox was kind enough to mail me a new BIOS chip to replace my locked
> chip.  This chip contained a version of the BIOS that I believe was
> dated 8/6/2001 (I don't feel like rebooting again to find out).  Suffice
> it to say, that version is not listed on their website, but there is an
> even newer one.  For anybody with the 8KTA3 or 8KTA3+, the BIOS page is
> located at http://www.epox.com/html/english/support/motherboard/bios/8kt3.htm

Maybe you meant 9/6/2001. That is the latest available version. From only
5 days ago.

> Anyway, I was running the BIOS dated 3/5/2001 up until now.

That was ancient! There were quite a few releases between then and now.

> The point to all this is that with the newer BIOS, my machine is now up and 
> running absolutely fine with Athlon optimization turned on.

Congratulations! (-: I would recommend you to run a long memtest86 as well
in particular tests 5 and 8. - They are the ones that used to fail for me
with the inappropriate memmory settings...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

