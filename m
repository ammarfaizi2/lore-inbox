Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291553AbSBAFNN>; Fri, 1 Feb 2002 00:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291552AbSBAFNE>; Fri, 1 Feb 2002 00:13:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50064 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291554AbSBAFMo>;
	Fri, 1 Feb 2002 00:12:44 -0500
Date: Fri, 1 Feb 2002 00:12:42 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020201001242.A25753@havoc.gtf.org>
In-Reply-To: <20020131.202509.78710127.davem@redhat.com> <26189.1012540213@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <26189.1012540213@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, Feb 01, 2002 at 04:10:13PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 04:10:13PM +1100, Keith Owens wrote:
> Why can't I do it?  Linus wants the current method, where monolithic
> Makefiles control initialization order.

Wrong, we have multi-level initcalls now.

	Jeff



