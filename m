Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282798AbRK0ErH>; Mon, 26 Nov 2001 23:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282796AbRK0Eq5>; Mon, 26 Nov 2001 23:46:57 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:48138 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S282798AbRK0Eqp>;
	Mon, 26 Nov 2001 23:46:45 -0500
Date: Tue, 27 Nov 2001 15:37:40 +1100
From: Anton Blanchard <anton@samba.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc-based cpu affinity user interface
Message-ID: <20011127153740.A13824@krispykreme>
In-Reply-To: <1006831902.842.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006831902.842.0.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is my procfs-based implementation of a user interface for
> getting and setting a task's CPU affinity.  Patch is against 2.4.16. 

Have you seen Andrew Mortons cpus_allowed patch?

http://www.zipworld.com.au/~akpm/linux/cpus_allowed.patch

Anton
