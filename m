Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWJMChz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWJMChz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 22:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWJMChz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 22:37:55 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:64597 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751561AbWJMChy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 22:37:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAPCXLkWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jiri Kosina <jikos@jikos.cz>
Subject: Re: lockdep warning in i2c_transfer() with dibx000 DVB - input tree merge plans?
Date: Thu, 12 Oct 2006 22:37:49 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       khali@linux-fr.org, i2c@lm-sensors.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610122237.52546.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 09:33, Jiri Kosina wrote:

> 
> What are the merge plans of input tree? Is it going in some short time 
> into mainline or into -mm?
> 

The patch os in my tree and Andrew pulled it in -mm. I am planning to ask
Linus to pull in the next couple of days.

-- 
Dmitry
