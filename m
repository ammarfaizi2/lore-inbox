Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315802AbSEEBIV>; Sat, 4 May 2002 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315803AbSEEBIU>; Sat, 4 May 2002 21:08:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7932
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315802AbSEEBIT>; Sat, 4 May 2002 21:08:19 -0400
Date: Sat, 4 May 2002 18:08:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: zftape-init.c compile error
Message-ID: <20020505010804.GB2392@matchmail.com>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD328C5.2C6D389A@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 10:18:13AM +1000, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > 
> > Full patchkit:
> > http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
> 
> linux-2.4-pre-aa/drivers/char/ftape/zftape/zftape-init.c fails to build,
> a declaration is put in an illegal place.
>

Why is it illegal to put that before the ifdef instead of after?

That's a litle strange looking diff output, what version is it?

Which compiler gave the error?
