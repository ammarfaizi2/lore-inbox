Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJQWxt>; Thu, 17 Oct 2002 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJQWxt>; Thu, 17 Oct 2002 18:53:49 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:21915 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262304AbSJQWxr> convert rfc822-to-8bit; Thu, 17 Oct 2002 18:53:47 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: RE: benchmarks of O_STREAMING in 2.5
Date: Fri, 18 Oct 2002 00:59:44 +0200
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210180059.44787.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Third and final test. Kernel compile (make -j2) with a couple streaming
> reads in the background.  Again, mem=2G.  This shows that actually
> saving the pagecache from the horrid waste is useful.
>
>        O_STREAMING     Wall time to complete Kernel compile
>        Yes             4m59.661s
>        No              5m30.494s
>
> So, uh, Andrew's 2.5 code works ;-)

Corrected version.

> Someone buy me a dual Xeon,
>
>        Robert Love

It's "Hammer time"...;-)

Greetings,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
