Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291433AbSAaXoH>; Thu, 31 Jan 2002 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291431AbSAaXn6>; Thu, 31 Jan 2002 18:43:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47754 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291425AbSAaXnk>;
	Thu, 31 Jan 2002 18:43:40 -0500
Date: Thu, 31 Jan 2002 18:43:38 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020131184338.A15025@havoc.gtf.org>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 31, 2002 at 11:24:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:24:10PM +0000, Alan Cox wrote:
> What I'd much rather see if this is an issue is:
> 
> bool	'Do you want to customise for a very small system' 
> 
> which auto enables all the random small stuff if you say no, and goes
> much deeper into options if you say yes.

CONFIG_SMALL or similar would indeed be nice...

	Jeff



