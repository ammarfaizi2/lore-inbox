Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLTPb4>; Wed, 20 Dec 2000 10:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQLTPbq>; Wed, 20 Dec 2000 10:31:46 -0500
Received: from p3EE3C909.dip.t-dialin.net ([62.227.201.9]:14853 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129597AbQLTPbe>; Wed, 20 Dec 2000 10:31:34 -0500
Date: Wed, 20 Dec 2000 16:01:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.2.18] VM: do_try_to_free_pages failed
Message-ID: <20001220160104.C13539@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001220130259.A9659@emma1.emma.line.org> <E148j3b-0001WK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E148j3b-0001WK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 20, 2000 at 13:13:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Alan Cox wrote:

> > How can I get rid of those do_try_to_free_pages lockups? That box
> > exports root file systems for some SparcStation 2 that are used as X
> > terminals, so it's pretty important I keep that box running.
> > 
> > Should I try the most recent 2.2.19-pre?
> 
> 2.2.19pre2 should resolve that problem

I'll give that a try. Thanks to you and Ville Herva for replying.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
