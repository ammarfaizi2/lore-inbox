Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264817AbTBTWzH>; Thu, 20 Feb 2003 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbTBTWzH>; Thu, 20 Feb 2003 17:55:07 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:36739 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264817AbTBTWzF>; Thu, 20 Feb 2003 17:55:05 -0500
Date: Fri, 21 Feb 2003 00:05:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.62-ac1
Message-ID: <20030220230507.GG1426@louise.pinerecords.com>
References: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@redhat.com]
> 
> Linux 2.5.62-ac1
> 
> This has more IDE and PCI toys. Handle with care. This brings most of the
> quirk handling from 2.4 into 2.5. The ALi Magick one requires the video4linux
> stuff is fixed in 2.5 as well. I've not yet merged the 450NX patch to mtrr
> (450NX mtrr write combining has errata)

Alan, this doesn't boot in my vmware setup while 2.5.62 vanilla does
(same config where applicable).  Never gets to do anything after
'Uncompressing Linux... Ok, booting the kernel.'  Any off-hand suspects?

-- 
Tomas Szepe <szepe@pinerecords.com>
