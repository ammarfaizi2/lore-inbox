Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVHDPCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVHDPCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVHDPBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:01:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51189 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262556AbVHDO60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:58:26 -0400
Subject: Re: wakeup race checking for RT
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org
In-Reply-To: <20050804144244.GB15447@elte.hu>
References: <1122932189.4623.25.camel@dhcp153.mvista.com>
	 <20050804144244.GB15447@elte.hu>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 07:58:18 -0700
Message-Id: <1123167498.9011.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 16:42 +0200, Ingo Molnar wrote:

> I've applied your patch, and have released the -52-13 PREEMPT_RT 
> patchset. [ But please be more careful with the coding style next time, 
> see below the number of fixups i had to do relative to your patch 
> (whitespaces, line length, code structure format, etc.). ]

	I do quite a bit of review before releasing, but it's hard to catch
that stuff unless you didn't write it. (or you read it backwards)

	I'll try to make more of an effort in the future..

Daniel

