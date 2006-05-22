Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWEVF7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWEVF7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWEVF7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:59:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:35245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932425AbWEVF7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:59:45 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <44714E4F.8000801@bigpond.net.au>
References: <4470CC8F.9030706@keyaccess.nl>
	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>
	 <200605221243.54100.kernel@kolivas.org> <1148267426.21765.15.camel@homer>
	 <4471305F.40105@bigpond.net.au> <1148273580.9914.3.camel@homer>
	 <44714E4F.8000801@bigpond.net.au>
Content-Type: text/plain
Date: Mon, 22 May 2006 08:00:57 +0200
Message-Id: <1148277658.10520.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 15:38 +1000, Peter Williams wrote:

> In my schedulers I generalize background to "soft cpu rate caps" with a 
> cap of zero being the same as background.  I have patches to add both 
> soft and hard cpu rate caps to the standard scheduler but I'm sitting on 
> them until things settle down a bit.

I look forward to seeing them.  Any chance of a preview?

	-Mike

