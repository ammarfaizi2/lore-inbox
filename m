Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315889AbSEGQUo>; Tue, 7 May 2002 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315890AbSEGQUn>; Tue, 7 May 2002 12:20:43 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:9861 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315889AbSEGQUn>; Tue, 7 May 2002 12:20:43 -0400
Date: Tue, 7 May 2002 12:20:43 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020507162010.GA13032@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 08:36:54AM -0700, Linus Torvalds wrote:
> On Tue, 7 May 2002, Anton Altaparmakov wrote:
> > As the new IDE maintainer so far we have only seen you removing one
> > feature after the other in the name of cleanup, without adequate or even
> > any at all(!) replacements,
> 
> Who cares? Have you found _anything_ that Martin removed that was at all
> worthwhile? I sure haven't.

I'm still hoping a patch will show up that will allow me to regain
access to my compactflash cards and IBM microdrive disks. The code
currently doesn't rescan for new drives when a card has been inserted,
although it still seems to have all the necessary logic.

Jan

