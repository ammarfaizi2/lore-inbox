Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWD1PjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWD1PjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWD1PjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:39:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:31169 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030441AbWD1PjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:39:04 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: kernel@kolivas.org, maeda.naoaki@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060428.225541.124090656.taka@valinux.co.jp>
References: <200604282011.36917.kernel@kolivas.org>
	 <44520581.3090404@jp.fujitsu.com> <200604282309.32320.kernel@kolivas.org>
	 <20060428.225541.124090656.taka@valinux.co.jp>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 17:39:03 +0200
Message-Id: <1146238743.7980.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 22:55 +0900, Hirokazu Takahashi wrote:
> I think you can introduce some threshold to estimate whether
> a process should be treated as an interactive process or not
> while vanilla kernel defines it statically.

Hmm.  What do you mean by static?  It is dynamic to my eyes.  The entire
mechanism is a dynamic priority mechanism.

If you know of anything that might help differentiate interactive tasks,
please speak up :)  It's really a bugger of a problem.

	-Mike

