Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbREYVBP>; Fri, 25 May 2001 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbREYVBF>; Fri, 25 May 2001 17:01:05 -0400
Received: from penguin.roanoke.edu ([199.111.154.8]:8453 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S261868AbREYVA4>; Fri, 25 May 2001 17:00:56 -0400
Message-ID: <3B0ECB0F.999B9856@linuxjedi.org>
Date: Fri, 25 May 2001 17:13:51 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT][PATCH] namespaces patch (2.4.5-pre6)
In-Reply-To: <Pine.GSO.4.21.0105251621400.28097-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Folks, new version of the patch is on
> ftp.math.psu.edu/pub/viro/namespaces-c-S5-pre6.gz
> 
>         News:
> * ported to 2.4.5-pre6
> * new (cleaner) locking mechanism
> * lock_super() is starting to become fs-private thing - first steps to
>   removing it from VFS code are done.
> 
> Please, help with testing. I'm feeding the pieces suitable for 2.4 into
> the Linus' tree, so patch got smaller.

OK, at the risk of asking a Stupid Question (tm), what exactly does
the namespaces patch buy us?  From the viewpoint of an
integrator/system admin?  I'd happily check it out if I thought it
would solve any of the problems I regularly see.

regards,
	David

-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of
Giants."
--Isaac Newton
