Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYJPH>; Thu, 25 Jan 2001 04:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAYJO6>; Thu, 25 Jan 2001 04:14:58 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:29903 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129444AbRAYJOl>; Thu, 25 Jan 2001 04:14:41 -0500
Date: Thu, 25 Jan 2001 09:14:22 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU error codes
In-Reply-To: <E14LbJ2-0008Be-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Alan Cox wrote:

> > I was wondering if someone could tell me where I can find
> > Xeon Pentium III cpu error messages/codes
> 
> In the intel databook. Generally an MCE indicates hardware/power/cooling
> issues

Doesn't an MCE also cover some hardware memory problems - parity/ECC
issues etc?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
