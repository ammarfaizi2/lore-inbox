Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVE0Jkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVE0Jkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVE0Jh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:37:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38861 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261783AbVE0Jes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:34:48 -0400
Date: Fri, 27 May 2005 15:12:58 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4: resent] cpuset exit NULL dereference fix
Message-ID: <20050527094258.GA5517@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050527090243.30833.93829.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527090243.30833.93829.sendpatchset@tomahawk.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:02:43AM -0700, Paul Jackson wrote:
> Andrew,
> 
> Resubmitting the same patch I submitted yesterday.  Simon Derr
> and I agree that we need this patch now to fix a kernel crash.
> 
> The potential scaling issues are theoretical at this time.
> When they become more real, we will be in a better position to
> consider more ambitious changes to cpuset locking and reference
> counting.
> 
> Meanwhile -- this patch is small, simple, and needed.
> 

Acked-by: Dinakar Guniguntala <dino@in.ibm.com>
