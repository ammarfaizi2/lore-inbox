Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVIGFDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVIGFDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 01:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVIGFDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 01:03:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43220 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751170AbVIGFDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 01:03:02 -0400
Subject: Re: Kernel 2.6.13 is hiding devices from /dev [Was Why is the 
	kernel hiding drbd devices?}
From: Lee Revell <rlrevell@joe-job.com>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: drbd-user@linbit.com, linux-kernel@vger.kernel.org
In-Reply-To: <a0623090dbf441d7a72a0@[129.98.90.227]>
References: <a06230908bf43b486d98f@[129.98.90.227]>
	 <1126063875.13159.31.camel@mindpipe>
	 <a0623090dbf441d7a72a0@[129.98.90.227]>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 01:03:00 -0400
Message-Id: <1126069380.13159.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 00:45 -0400, Maurice Volaski wrote:
> >What is drbd?  An out of tree driver?  Did it work with 2.6.13-rcX?  If
> 
> Yes, it implements RAID 1 across two computers over a network link in 
> realtime. Generally, you combine with a program called heartbeat to 
> implement high-availabilty failover. It's very neat ;-)

They should get it merged then.  Anyway, I'm glad it's working...

Lee

