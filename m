Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbRCGQrm>; Wed, 7 Mar 2001 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbRCGQrd>; Wed, 7 Mar 2001 11:47:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:15364 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131113AbRCGQrZ>;
	Wed, 7 Mar 2001 11:47:25 -0500
Date: Wed, 7 Mar 2001 17:46:31 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver
Message-ID: <20010307174631.A27245@caldera.de>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103071442.PAA14348@ns.caldera.de> <200103071529.f27FTjO26978@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200103071529.f27FTjO26978@aslan.scsiguy.com>; from gibbs@scsiguy.com on Wed, Mar 07, 2001 at 08:29:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 08:29:45AM -0700, Justin T. Gibbs wrote:
> >What about simply removing the firmware source and assembler from the
> >kernel tree?  We have lots of firmware in the kernel tree for which
> >there isn't even firmware  avaible...
> 
> What, and not allow others to fix my bugs for me? :-)
> 
> Lots of people have embedded this driver just because it is completely
> open source.  I'd like to have all distributions be "complete"
> distributions.

Not having it in the kernel tree doesn't have to mean not having it in
the distributions.  If you are really concerned having iy in the kernel
tree it might also be a good idea to have it in scripts.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
