Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVJJQt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVJJQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVJJQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:49:59 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:52023 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750930AbVJJQt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:49:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MwVvubSMd5wZ7chWLsdX6pGLrPHWFXH5vmeyWyNZvzlABU/zEPb4sQOuolSos+onzNPcnDVXM5sPJW83LhFWxWdkyITAsCHntdTP/uFqCTUSWr9ilueyHTYrdPMJdJpgUqDjHCJ/dnBDuSg6RNv6afcPqJpehxvFCgZSEaMSVH8=
Message-ID: <40f323d00510100949x3331ad4drf86ea676c39c0bfb@mail.gmail.com>
Date: Mon, 10 Oct 2005 18:49:53 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Subject: Re: Direct Rendering drivers for ATI X300 ?
Cc: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0510101838580.25345@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
	 <Pine.LNX.4.60.0510101838580.25345@kepler.fjfi.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> On Mon, 10 Oct 2005, Gerhard Mack wrote:
>
> > Hello,
> >
> > Can anyone tell me if there are working open source DRM drivers that work
> > on recent 2.6.x kernels for the ATI X300?  I've tried dri.sourceforge.net
> > and r300 but neither seems to even bother compiling.  I've spent several
> > hours on google without luck.
> >
> >       Gerhard
>
> Have you seen this
>
>         http://r300.sourceforge.net/
>

i think it is now in mesa/xorg cvs:
from their website
"07/22/05  Latest version of Mesa and DRM drivers have been accepted
in DRM and Mesa CVS trees on freedesktop.org CVS"

regards,

Benoit
