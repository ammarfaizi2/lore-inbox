Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbREBITn>; Wed, 2 May 2001 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbREBITe>; Wed, 2 May 2001 04:19:34 -0400
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:43016 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S131563AbREBIT2>; Wed, 2 May 2001 04:19:28 -0400
Date: Wed, 2 May 2001 10:19:20 +0200 (CEST)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-via@gtf.org>
Subject: Re: PATCH 2.4.4: Via audio fixes
In-Reply-To: <3AED958C.3F9EBE1B@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0105021018300.15603-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Jeff Garzik wrote:

> The attached patch includes fixes to the Via audio driver for which I'm
> interested finding testers.  Testing and a private "it works" (hopefully
> :)) or "it doesn't work, <here> is what breaks for me" would be
> appreciated.

Works as before -> mono recording does _not_ work, i.e. gives garbage
(as described in sf bugreport).

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

