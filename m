Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266634AbUBMA4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266637AbUBMA4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:56:41 -0500
Received: from wacom-nt2.wacom.com ([204.119.25.126]:25608 "EHLO
	wacom_nt2.WACOM.COM") by vger.kernel.org with ESMTP id S266634AbUBMA4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:56:40 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065BCA@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: "'Pete Zaitcev'" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: RE: Wacom USB driver patch
Date: Thu, 12 Feb 2004 16:55:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wacom.c at http://linux.bkbits.net:8080/linux-2.4 is way out of date and
people are still working on/using 2.4 releases. Should I make a patch for
2.4?

Ping

-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Wednesday, February 11, 2004 12:05 PM
To: Ping Cheng
Cc: 'Pete Zaitcev'; linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch


On Wed, Feb 11, 2004 at 11:47:19AM -0800, Ping Cheng wrote:
> Nice catch, Pete. The Two "return"s should be replaced by "goto exit".
> 
> Vojtech, should I make another patch or you can handle it with my 
> previous one?

It's okay, you don't need to make another patch.

