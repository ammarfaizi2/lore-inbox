Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264756AbUEESsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbUEESsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbUEESsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 14:48:42 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:29705 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264756AbUEESsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 14:48:42 -0400
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Steve Lord <lord@xfs.org>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40991A8D.5000008@xfs.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	 <200405051312.30626.dominik.karall@gmx.net>
	 <20040505043002.2f787285.akpm@osdl.org>  <40991A8D.5000008@xfs.org>
Content-Type: text/plain
Message-Id: <1083782911.1765.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 05 May 2004 20:48:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 18:47, Steve Lord wrote:

> There are other combinations which worry me. I do wonder how close to the
> edge some of these are living now and cutting them off at the knees, stack
> wise, is going to bite later. How many folks run the mm kernel in production
> server environments?

Me... Although the servers aren't critical. However, I know I'm a
minority...

