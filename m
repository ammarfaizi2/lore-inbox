Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131840AbQL2Sxo>; Fri, 29 Dec 2000 13:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbQL2SxY>; Fri, 29 Dec 2000 13:53:24 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:3857 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S131794AbQL2SxU>;
	Fri, 29 Dec 2000 13:53:20 -0500
Date: Fri, 29 Dec 2000 23:52:05 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: How to write patches
Message-ID: <Pine.SOL.3.96.1001229234454.12681A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This question may seem naive, but can anyone tell me if there is any
structured way of writing patches? 

I mean suppose I want to implement some
kernel mechanism, and I define my data structures etc. and made most of
the code as loadable  module to start with, but still I am having to
change some parts of the kernel code at the development time, and I
want to make that change using patches, so that I do not have to browse
thru the files to change the code as I debug. 

Is there any structured way of doing this?

Happy New Year
Sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
