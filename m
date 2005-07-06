Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVGFKJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVGFKJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGFKF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:05:59 -0400
Received: from [203.171.93.254] ([203.171.93.254]:59868 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262179AbVGFIML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:12:11 -0400
Subject: Re: [PATCH] [16/48] Suspend2 2.1.9.8 for 2.6.12:
	406-dynamic-pageflags.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1120635983.6970.4.camel@linux-hp.sh.intel.com>
References: <11206164411593@foobar.com>
	 <1120635983.6970.4.camel@linux-hp.sh.intel.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120637607.4860.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 18:13:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 17:46, Shaohua Li wrote:
> we are using cpu hotplug for S3 & S4 SMP to avoid nasty deadlocks. Could
> this be avoided in suspend2 SMP?

I haven't had any problems with this code but yes, I do want to switch
to using hotplug. It's only in -mm, not mainline?

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

