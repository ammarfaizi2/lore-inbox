Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280751AbRKYHcf>; Sun, 25 Nov 2001 02:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280752AbRKYHcY>; Sun, 25 Nov 2001 02:32:24 -0500
Received: from queen.bee.lk ([203.143.12.182]:40066 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S280751AbRKYHcT>;
	Sun, 25 Nov 2001 02:32:19 -0500
Date: Sun, 25 Nov 2001 13:31:57 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: James Davies <james_m_davies@yahoo.com>
Cc: Wayne.Brown@altec.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.0
Message-ID: <20011125133157.A2190@bee.lk>
In-Reply-To: <86256B0F.0026CFDE.00@smtpnotes.altec.com> <20011125071857Z280740-17408+19611@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011125071857Z280740-17408+19611@vger.kernel.org>; from james_m_davies@yahoo.com on Sun, Nov 25, 2001 at 05:14:53PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 05:14:53PM +1000, James Davies wrote:
> On Sun, 25 Nov 2001 16:52, Wayne.Brown@altec.com wrote:
> > Is there going to be an "official" patch from 2.4.15 to 2.5.0?  I'd rather
> > not ftp the whole kernel tarball over a modem connection, and I don't have
> > the disk space on my laptop to keep both the complete 2.4 and 2.5 source at
> > the same time anyway.
> 
> 2.4.15 is the same as 2.5.0

I think he is concerned about the _official_ 2.4.15 and the _official_ 2.5.0,
because, subsequent patches for 2.5.0 will not _cleanly_ apply on 2.4.15 tree
(although fixing them should be extremely trivial).

Can somebody confirm that the difference is only the version numbers in the
Makefile, and no other changes in Documentation/ etc?

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

The human animal differs from the lesser primates in his passion for
lists of "Ten Best".
		-- H. Allen Smith

