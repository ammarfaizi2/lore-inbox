Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284576AbRLETVG>; Wed, 5 Dec 2001 14:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284586AbRLETU5>; Wed, 5 Dec 2001 14:20:57 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13308
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284576AbRLETUt>; Wed, 5 Dec 2001 14:20:49 -0500
Date: Wed, 5 Dec 2001 11:20:41 -0800
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: hints at modifying kswapd params in 2.4.16
Message-ID: <20011205192041.GA9050@mikef-linux.matchmail.com>
Mail-Followup-To: Sven Heinicke <sven@research.nj.nec.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <15373.13379.382015.406274@abasin.nj.nec.com> <E16BMqa-0003V2-00@the-village.bc.nu> <15374.13775.921872.835210@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15374.13775.921872.835210@abasin.nj.nec.com>
User-Agent: Mutt/1.3.24i
From: Mike Fedyk <mfedyk@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 09:57:19AM -0500, Sven Heinicke wrote:
> 
> I'm not sure if I was understood here.  On both Mandrake 8.0 and Red
> Hat 7.1 I'm running the 2.4.16 kernel with the same .confg file, and
> built on there respective kernel.  And I'm getting the below different
> memory usage patterns with the same processes running.  Seems
> something external to the kernel is causing the differences.
> 
> As of this morning, December 5th, the Mandrake systems has run longer
> then the same kernel ever did on Red Hat.  I say again, with the same
> kernel source and same .confg file.
> 

What about compiler version, glibc version, and hardware revision (think
lspci) differences?
