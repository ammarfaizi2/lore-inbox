Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSKUUyp>; Thu, 21 Nov 2002 15:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSKUUyp>; Thu, 21 Nov 2002 15:54:45 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:19926 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S264749AbSKUUyn>; Thu, 21 Nov 2002 15:54:43 -0500
Date: Thu, 21 Nov 2002 15:03:47 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
Message-ID: <20021121150347.A32601@vger.timpanogas.org>
References: <15835.56316.564937.169193@robur.slu.se> <20021120164319.A26918@vger.timpanogas.org> <15836.47295.808423.41648@robur.slu.se> <20021121111010.A31363@vger.timpanogas.org> <15835.56316.564937.169193@robur.slu.se> <3DDD141F.4010402@pobox.com> <20021121113042.A31516@vger.timpanogas.org> <15835.56316.564937.169193@robur.slu.se> <3DDD185C.9080803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DDD185C.9080803@pobox.com>; from jgarzik@pobox.com on Thu, Nov 21, 2002 at 12:31:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks

jeff

On Thu, Nov 21, 2002 at 12:31:08PM -0500, Jeff Garzik wrote:
> Jeff V. Merkey wrote:
> 
> > >NAPI poll does not happen in an interrupt.  Doing things in interrupts
> > >is the source of problems that NAPI is trying to solve.
> > >
> > >Other than that, please read the code and NAPI paper...  :)
> >
> >
> >
> >
> > Where can I find it?
> 
> 
> 
> In the link Robert Ollson gave to you (paper), and the Linux kernel (code).
> 
> 	Jeff
> 
> 
