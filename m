Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTKFXie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKFXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:38:34 -0500
Received: from eleanor.physics.ucsb.edu ([128.111.8.116]:33220 "EHLO
	eleanor.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S263873AbTKFXic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:38:32 -0500
Date: Thu, 6 Nov 2003 15:39:44 -0800 (PST)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: <bugs@x86-64.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug when mounting SCSI CD-ROM
In-Reply-To: <200311061402.17255.pbadari@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0311061537210.23799-100000@eleanor.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Badari Pulavarty wrote:

>I ran into the same problem earlier on my AMD64 box.
>Try disabling IOMMU_DEBUG.

>Let me know, if this fixes the problem for you.

Hi Badari,

That does prevent the problem. I also received email from Andi Kleen, who
is looking into the problem.

Thanks!

--
David Whysong                                       dwhysong@physics.ucsb.edu
Astrophysics graduate student         University of California, Santa Barbara
My public PGP keys are on my web page - http://www.physics.ucsb.edu/~dwhysong
DSS PGP Key 0x903F5BD6  :  FE78 91FE 4508 106F 7C88  1706 B792 6995 903F 5BD6
D-H PGP key 0x5DAB0F91  :  BC33 0F36 FCCD E72C 441F  663A 72ED 7FB7 5DAB 0F91

