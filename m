Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbRFYPyO>; Mon, 25 Jun 2001 11:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFYPxy>; Mon, 25 Jun 2001 11:53:54 -0400
Received: from ns.caldera.de ([212.34.180.1]:17900 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S264642AbRFYPxt>;
	Mon, 25 Jun 2001 11:53:49 -0400
Date: Mon, 25 Jun 2001 17:53:00 +0200
Message-Id: <200106251553.f5PFr0v17268@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: vonbrand@sleipnir.valparaiso.cl (Horst von Brand)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making a module 2.4 compatible
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200106241713.f5OHDItV000540@sleipnir.valparaiso.cl>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horst,

In article <200106241713.f5OHDItV000540@sleipnir.valparaiso.cl> you wrote:
> Seconded! There are a few users of iBCS around here, who _need_ the
> functionality and don't get it with 2.4.x (in this case, Red Hat 7.1). Or
> is there a replacement for it?

Take a look at inux-abi:

  http://linux-abi.sourceforge.net
  ftp://ftp.openlinux.org/pub/people/hch/linux-abi
