Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWAFKG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWAFKG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWAFKG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:06:59 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:49904 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932141AbWAFKG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:06:58 -0500
X-ME-UUID: 20060106100657307.4AFF11C002AA@mwinf0601.wanadoo.fr
Subject: Re: Add tainting for proprietary helper modules.
From: Xavier Bestel <xavier.bestel@free.fr>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, rms@gnu.org, torvalds@osdl.org
In-Reply-To: <20060106094933.GB2807@localhost.localdomain>
References: <20051203004102.GA2923@redhat.com>
	 <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
	 <20051205173041.GE12664@redhat.com>
	 <20060106094933.GB2807@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1136541981.23641.56.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 06 Jan 2006 11:06:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 10:49, Coywolf Qi Hunt wrote:

> You've hard-coded some module names, that itself `taints' the
> kernel source IMO.  Blacklisting in kernel is both ugly and unacceptable.

How about that: continue to blacklist ndiswrapper until it has
capability to taint itself the kernel when loading a proprietary driver.

	Xav


