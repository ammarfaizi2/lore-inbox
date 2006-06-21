Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWFUM4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWFUM4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWFUMzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:55:48 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:51211 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932092AbWFUMzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:55:25 -0400
In-Reply-To: <1150755573.6780.38.camel@localhost.localdomain>
References: <1150643426.27073.17.camel@localhost.localdomain> <449580CA.2060704@gmail.com> <1150660202.27073.23.camel@localhost.localdomain> <200606192209.38403.kernel@kolivas.org> <1150720304.27073.70.camel@localhost.localdomain> <20060619215822.GA4178@linux.intel.com> <1150755573.6780.38.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49ABE023-2FB8-4E74-B6CD-E647E4F6608F@oxley.org>
Cc: mgross@linux.intel.com, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ
Date: Wed, 21 Jun 2006 13:54:55 +0100
To: tglx@timesys.com
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Jun 2006, at 23:19, Thomas Gleixner wrote:

> FACTOR=20 batches the timer wheel timers to 40ms on a HZ=250 kernel

Should that read 80ms?

//felix
