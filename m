Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312720AbSCZWeg>; Tue, 26 Mar 2002 17:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312527AbSCZWe0>; Tue, 26 Mar 2002 17:34:26 -0500
Received: from hera.cwi.nl ([192.16.191.8]:56009 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312720AbSCZWeQ>;
	Tue, 26 Mar 2002 17:34:16 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 22:34:15 GMT
Message-Id: <UTC200203262234.WAA423816.aeb@cwi.nl>
To: adasi@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: ioctl_list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adasi@kernel.pl asks:

    I've found it in manpages, but it's for kernel 1.3...
    Where can I find actual, full, briefly descripted list of ioctl's?
    WK

Probably none exists.
The proper place would be the Documentation/DocBook subdirectory
of the kernel source tree.
It would be a very good idea if someone started this by
nicely documenting some of the ioctls. Once there is a start
people will add to it until it is complete.
