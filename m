Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKDAB4>; Fri, 3 Nov 2000 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbQKDABq>; Fri, 3 Nov 2000 19:01:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9222 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129066AbQKDABk>;
	Fri, 3 Nov 2000 19:01:40 -0500
Message-ID: <3A0351D7.39F0FB14@mandrakesoft.com>
Date: Fri, 03 Nov 2000 19:01:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sunol_handa@non.agilent.com
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: linux support for TCP/IP Task Offload ....
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971A3D977@xsj02.sjs.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sunol_handa@non.agilent.com wrote:
> 
> thanx for the information
> 
> this ftp site
> ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-*.dif
> is password protected.
> 
> do you know what the password is ? or is there a site with same patch which
> is not password protected.

This site is not password-protected, I just downloaded the referenced
diff.  Are you trying to download the above URL directly?  You cannot...
URLs do not have wildcards in them.  Download the following files:

ftp://ftp.inr.ac.ru/ip-routing/README.zerocopy-sendfile
ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-001102.dif.gz

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
