Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266142AbRGDTUe>; Wed, 4 Jul 2001 15:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266144AbRGDTUY>; Wed, 4 Jul 2001 15:20:24 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:15889 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S266142AbRGDTUU>;
	Wed, 4 Jul 2001 15:20:20 -0400
Date: Wed, 4 Jul 2001 13:20:18 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
Message-ID: <20010704132018.D10863@qcc.sk.ca>
In-Reply-To: <994279551.1116.0.camel@tux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <994279551.1116.0.camel@tux>; from rbultje@ronald.bitfreak.net on Wed, Jul 04, 2001 at 10:45:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:
> 
> you might remember an e-mail from me (two weeks ago) with my problems
> where linux would not boot up or be highly instable on a machine with
> 256 MB RAM, while it was 100% stable with 128 MB RAM. Basically, I still
> have this problem, so I am running with 128 MB RAM again.
[...]
> I'm getting desperate.... win2k is running stable and it's scary to see
> linux crash while win2k runs stable and smooth.

It's likely hardware problems.  Different OSes excercise the memory subsystems
quite differently, so it's possible (and common) to see problems in one OS
where another appears to run fine.

Download memtest86 and test your system with 256MB in it -- if it reports any
problems, it's definitely hardware.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
