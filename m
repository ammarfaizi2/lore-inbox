Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSEEJnW>; Sun, 5 May 2002 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSEEJnV>; Sun, 5 May 2002 05:43:21 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12017
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290289AbSEEJnV>; Sun, 5 May 2002 05:43:21 -0400
Date: Sun, 5 May 2002 02:43:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020505094304.GG2392@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3CD13FF3.5020406@evision-ventures.com> <E173IKu-00047S-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 04:17:36PM +0100, Alan Cox wrote:
> > Far better sollution then just versioning the kernel release
> 
> The kernel release isnt useful info. Many interfaces are stable across
> multiple kernels, many interface issues depend on things other than kernel
> version. Lots of people apply patches and don't change the base kernel
> version - in fact its hard to do so

Changing one line in Makefile is hard?  I do that every time I patch my
kernels.  It lets me track easily what kernels I have installed just by `ls
/boot`, and the name shows up in my kernel .deb. :)
