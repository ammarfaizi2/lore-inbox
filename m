Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291813AbSBAQFx>; Fri, 1 Feb 2002 11:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291814AbSBAQFg>; Fri, 1 Feb 2002 11:05:36 -0500
Received: from mustard.heime.net ([194.234.65.222]:40923 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S291813AbSBAQFV>; Fri, 1 Feb 2002 11:05:21 -0500
Date: Fri, 1 Feb 2002 17:05:03 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, Roger Larsson <roger.larsson@norran.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
In-Reply-To: <20020131223754.V5301@suse.de>
Message-ID: <Pine.LNX.4.30.0202011621220.29309-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something ala this, completely untested. Will try and boot it now :-)
> Roy, could you please test? It's against 2.4.18-pre7, I'll boot it now
> as well...

Still problems after installing the patch. No change at all. The patch was
installed against 2.4.17-rmap12a+ide+tux.

Testing with Apache2 now (apache2 uses mmap instead of sendfile() as
far as I can see) ... these tests take some time

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.




