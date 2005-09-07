Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVIGDbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVIGDbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 23:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVIGDbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 23:31:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61894 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750935AbVIGDbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 23:31:21 -0400
Subject: Re: Kernel 2.6.13 is hiding devices from /dev [Was Why is the
	kernel hiding drbd devices?}
From: Lee Revell <rlrevell@joe-job.com>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: drbd-user@linbit.com, linux-kernel@vger.kernel.org
In-Reply-To: <a06230908bf43b486d98f@[129.98.90.227]>
References: <a06230908bf43b486d98f@[129.98.90.227]>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 23:31:14 -0400
Message-Id: <1126063875.13159.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 17:13 -0400, Maurice Volaski wrote:
> The kernel module drbd (version 0.7.13) can no longer find its 
> devices (e.g., /dev/drbd0, /dev/drbd1) in kernel 2.6.13. The version 
> of udev I am using 065/068 didn't make a difference. It works fine 
> with kernel 2.6.12.5 and 2.6.12.6.

What is drbd?  An out of tree driver?  Did it work with 2.6.13-rcX?  If
not, why didn't they tell us sooner?  Does it expect devfs to be present
in the kernel by any chance?

Lee

