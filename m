Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUJNUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUJNUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJNUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:55:23 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44729 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267516AbUJNUrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:47:25 -0400
Message-Id: <200410142047.i9EKlkg12327@raceme.attbi.com>
Subject: Re: Driver access ito PCI card memory space question.
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Oct 2004 15:47:46 -0500 (CDT)
From: kilian@bobodyne.com (Alan Kilian)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  I want to thank everyone for helping me get my Solaris driver 
  running under Linux.

  It's taken three days, but it appears to be working, it passes all
  my hardware diagnostics and I'm ready to hook it up to the
  application layer. I think going from knowing NOTHING about the
  Linux kernel to a working PCI bus driver in three days is not too 
  shabby.
  
  The Rubini and Corbet book helped a LOT, but it helped more after
  I knew what I was doing a bit.

  I suspect I'll be back when I start implementing the DMA part.

  Hey! what RPM do I install so I can get man pages for kernel
  functions? A man page for readl() sure would have been useful.

  Thanks a million folks!!!

                            -Alan

-- 
- Alan Kilian <kilian(at)timelogic.com> 
Director of Bioinformatics, TimeLogic Corporation 763-449-7622
