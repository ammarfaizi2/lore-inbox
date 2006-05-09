Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWEIOiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWEIOiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWEIOiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:38:11 -0400
Received: from ns1.mvista.com ([63.81.120.158]:21818 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750713AbWEIOiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:38:10 -0400
Subject: Re: rt20 patch question
From: Daniel Walker <dwalker@mvista.com>
To: markh@compro.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <446089CF.3050809@compro.net>
References: <446089CF.3050809@compro.net>
Content-Type: text/plain
Date: Tue, 09 May 2006 07:38:02 -0700
Message-Id: <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 08:23 -0400, Mark Hounschell wrote:
> Can I assume configuring 'Complete preemption' is the same as
> configuring ('Voluntary preemption' + 'Hardirq' + 'Softirq' + default
> proc settings)?

Not Voluntary preemption, and I'm not sure what default proc settings is
referring too . Complete preemption is like CONFIG_PREEMPT and softirq
and hardirq threading .. The preemption isn't voluntary, it's forced .

Daniel

