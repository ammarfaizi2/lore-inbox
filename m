Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKFOzU>; Mon, 6 Nov 2000 09:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKFOzK>; Mon, 6 Nov 2000 09:55:10 -0500
Received: from mean.netppl.fi ([195.242.208.16]:5894 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S129047AbQKFOyz>;
	Mon, 6 Nov 2000 09:54:55 -0500
Date: Mon, 6 Nov 2000 16:54:53 +0200
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: linux support for TCP/IP Task Offload ....
Message-ID: <20001106165452.A19367@netppl.fi>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971A3D977@xsj02.sjs.agilent.com> <3A0351D7.39F0FB14@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3A0351D7.39F0FB14@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 07:01:27PM -0500, Jeff Garzik wrote:
> sunol_handa@non.agilent.com wrote:
> > 
> > thanx for the information
> > 
> > this ftp site
> > ftp://ftp.inr.ac.ru/ip-routing/zerocopy-sendfile-*.dif
> > is password protected.
> > 

> This site is not password-protected, I just downloaded the referenced
> diff.  Are you trying to download the above URL directly?  You cannot...
> URLs do not have wildcards in them.  Download the following files:
The site also used to require the use of passive-mode ftp, which might
be your problem.

You might want to try 
ftp://ftp.funet.fi/pub/mirrors/ftp.inr.ac.ruk/ip-routing which is
probably a lot faster anyway.

great for me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
