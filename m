Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSFHIcn>; Sat, 8 Jun 2002 04:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFHIcm>; Sat, 8 Jun 2002 04:32:42 -0400
Received: from gw-nl6.philips.com ([212.153.235.103]:2432 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP
	id <S317388AbSFHIcl>; Sat, 8 Jun 2002 04:32:41 -0400
From: hari.sharma@philips.com
Subject: ioremap problem
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF154AE9A4.21574E3D-ON65256BD2.002EB9FF@diamond.philips.com>
Date: Sat, 8 Jun 2002 14:01:01 +0530
X-MIMETrack: Serialize by Router on ehv001soh/H/SERVER/PHILIPS(Release 5.0.9a |January 7, 2002) at
 08/06/2002 10:33:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> I m developing a kernel module for PCI interface. Using redhat 7.1. While I try to load the module it says ioremap symbol not defined. asm/io.h is included in the module source. Any input is welcome.Thanx in advance.

