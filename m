Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbSJaVLU>; Thu, 31 Oct 2002 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265240AbSJaVLR>; Thu, 31 Oct 2002 16:11:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:1481 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265279AbSJaVK4>;
	Thu, 31 Oct 2002 16:10:56 -0500
Subject: Re: [PATCH] fix timer_pit.c warning
From: john stultz <johnstul@us.ibm.com>
To: John Levon <levon@movementarian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031030500.GA3642@compsoc.man.ac.uk>
References: <20021031030500.GA3642@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 13:13:54 -0800
Message-Id: <1036098835.12713.53.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 19:09, John Levon wrote:
> 
> make x86_do_profile available when UP=y,LOCAL_APIC=n

My bad, good catch.

thanks,
-john


