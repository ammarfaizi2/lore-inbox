Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWEIPxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWEIPxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEIPxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:53:45 -0400
Received: from ns1.mvista.com ([63.81.120.158]:62843 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751189AbWEIPxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:53:45 -0400
Subject: Re: rt20 patch question
From: Daniel Walker <dwalker@mvista.com>
To: markh@compro.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4460ADF8.4040301@compro.net>
References: <446089CF.3050809@compro.net>
	 <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <4460ADF8.4040301@compro.net>
Content-Type: text/plain
Date: Tue, 09 May 2006 08:53:43 -0700
Message-Id: <1147190023.21536.23.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 10:58 -0400, Mark Hounschell wrote:

> 
> So If I config Voluntary preemption + Hardirq and Softirq threading and
> do not disable hardirq or softirq via proc or boot cmdline, is that the
> same as configuring Complete preemption?


No .

Daniel

