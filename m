Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275757AbRI0E1s>; Thu, 27 Sep 2001 00:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRI0E1j>; Thu, 27 Sep 2001 00:27:39 -0400
Received: from hermes.toad.net ([162.33.130.251]:61892 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S275757AbRI0E1X>;
	Thu, 27 Sep 2001 00:27:23 -0400
Message-ID: <3BB2AAA5.CDDD6965@yahoo.co.uk>
Date: Thu, 27 Sep 2001 00:27:17 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Re: 2.4.9-ac15 painfully sluggish
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know next to nothing about these VM issues, but here's
another data point:

2.4.9-ac15 was painfully sluggish on my ThinkPad 600,
Pentium II, 120 MB RAM system just running galeon
or compiling a kernel.  The disk would begin thrashing
and continue doing so for many minutes.  Swap usage was
reported as zero the whole time.

I applied the "2.4.9-ac15-age+launder" patch and things
improved dramatically.

--

Thomas
