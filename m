Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWEVCoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWEVCoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 22:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWEVCoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 22:44:32 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:41095 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964984AbWEVCob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 22:44:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
Date: Mon, 22 May 2006 12:43:53 +1000
User-Agent: KMail/1.9.1
Cc: Rene Herman <rene.herman@keyaccess.nl>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <4470CC8F.9030706@keyaccess.nl> <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>
In-Reply-To: <1148264043.7643.15.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221243.54100.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 12:14, Mike Galbraith wrote:
> In my tree, I don't use the expired array for anything except batch
> tasks any more for this very reason. The latency just hurts too bad.

So it's turning your tree into a single priority array design effectively just 
like staircase ;) ?

-- 
-ck
