Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135343AbRAJLEM>; Wed, 10 Jan 2001 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135324AbRAJLED>; Wed, 10 Jan 2001 06:04:03 -0500
Received: from sun.rhrk.uni-kl.de ([131.246.137.50]:61584 "HELO
	sun.rhrk.uni-kl.de") by vger.kernel.org with SMTP
	id <S135325AbRAJLDc>; Wed, 10 Jan 2001 06:03:32 -0500
Date: Wed, 10 Jan 2001 12:03:23 +0100
From: Dirk Mueller <dmuell@gmx.net>
To: BUGTRAQ@securityfocus.com, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010110120323.A30374@rotes20.wohnheim.uni-kl.de>
Mail-Followup-To: Dirk Mueller <dmuell@gmx.net>, BUGTRAQ@SECURITYFOCUS.COM,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20010110004201.A308@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010110004201.A308@cerebro.laendle>; from pcg@goof.com on Wed, Jan 10, 2001 at 12:42:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The best workaround at this time seems to be to uninstall reiserfs
> completely or not allow any user access (even indirect) to these volumes.
> While this individual bug might be easy to fix, we believe that other,
> similar bugs should be easy to find so reiserfs should not be trusted (it
> shouldn't be trusted to full user access for other reasons anyway, but it
> is still widely used).

Can you please calm down ? Just because you maybe found ONE bug you cannot 
say that there are more issues except this one without even knowing them!

If it helps, I'm using 2.2.18+reiserfs-3.5.29+ide-dma patch and I cannot 
reproduce ANYTHING said in the referred message. It works perfectly fine. 
I was using gcc 2.95.2 to compile the kernel. 


Dirk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
