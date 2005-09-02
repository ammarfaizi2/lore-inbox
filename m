Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbVIBBsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbVIBBsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbVIBBsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:48:38 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:14110 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030637AbVIBBsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:48:38 -0400
Date: Fri, 02 Sep 2005 10:43:59 +0900 (JST)
Message-Id: <20050902.104359.26944961.hyoshiok@miraclelinux.com>
To: ak@suse.de
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <200509011136.38057.ak@suse.de>
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com>
	<20050901.180723.982928921.hyoshiok@miraclelinux.com>
	<200509011136.38057.ak@suse.de>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
> On Thursday 01 September 2005 11:07, Hiro Yoshioka wrote:
> 
> > The following is the almost final version of the
> > cache pollution aware __copy_from_user_ll() patch.
> 
> Looks good to me.
> 
> Once the filemap.c hunk is in I'll probably do something
> similar for x86-64.

Thank you very much. What else should I do? Shall I just
be waiting to check in the patch?

Regards,
  Hiro
