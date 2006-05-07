Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWEGR7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWEGR7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWEGR7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:59:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30633 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932215AbWEGR7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:59:32 -0400
Subject: Re: rtc: lost some interrupts at 256Hz
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Monnerie <michael.monnerie@it-management.at>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200604251232.37939@zmi.at>
References: <200604202237.34134@zmi.at> <1145566983.5412.31.camel@mindpipe>
	 <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
	 <200604251232.37939@zmi.at>
Content-Type: text/plain
Date: Sun, 07 May 2006 13:59:28 -0400
Message-Id: <1147024769.15364.260.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 12:32 +0200, Michael Monnerie wrote:
> Still, some kind of documentation in the Linux source tree would be 
> nice, explaining what that message means and how to fix it.
> 

It means exactly what the printk says:

"Your time source seems to be instable or 
some driver is hogging interupts"

Lee

