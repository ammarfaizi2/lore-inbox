Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272669AbRHaLbM>; Fri, 31 Aug 2001 07:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272670AbRHaLbC>; Fri, 31 Aug 2001 07:31:02 -0400
Received: from dsl092-103-029.nyc2.dsl.speakeasy.net ([66.92.103.29]:9477 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S272669AbRHaLax>; Fri, 31 Aug 2001 07:30:53 -0400
Date: Fri, 31 Aug 2001 07:31:16 -0400 (EDT)
From: Sam Varshavchik <mrsam@courier-mta.com>
X-X-Sender: <geo@ny.email-scan.com>
Reply-To: mrsam@courier-mta.com
To: "Floydsmith@aol.com" <Floydsmith@aol.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re2: ATAPI Floppy Problem - not bogas with ls-120 2.4.9
In-Reply-To: <e4.1a14f481.28c07763@aol.com>
Message-ID: <Pine.LNX.4.33.0108310351370.30735-100000@ny.email-scan.com>
X-No-Archive: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Floydsmith@aol.com wrote:

> >This should be fixed in -ac4.  It's a bogus message.  Ignore it.
>
> This message is not a bogas message with ls-120 drives in 2.4.9. No problem
> occurs in 2.4.8. And, no problem occurs in 2.4.9 if the ide-floppy.c and
> ide.c from 2.4.8 replace the ones in 2.4.9. But, if the 2.4.9 kernel is built
> as is, then message appears on boot up and on attempting to mount a ls-120
> diskette even if a disketee is in the drive!

Right, and that's what makes it bogus.

-- 
Sam

