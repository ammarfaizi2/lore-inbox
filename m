Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSC0Nk6>; Wed, 27 Mar 2002 08:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313013AbSC0Nks>; Wed, 27 Mar 2002 08:40:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:51721 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313012AbSC0Nkf>;
	Wed, 27 Mar 2002 08:40:35 -0500
Subject: Re: Scheduler priorities
From: Robert Love <rml@tech9.net>
To: Nuno Miguel Rodrigues <nmr@co.sapo.pt>
Cc: Frank Schaefer <frank.schafer@setuza.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020327125828.U2343-100000@angelina.sl.pt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Mar 2002 08:41:51 -0500
Message-Id: <1017236512.16546.116.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-27 at 08:06, Nuno Miguel Rodrigues wrote:

> Indeed.  In other words a priority that is not dynamically adjusted over
> time.  Like a real-time scheduling priority.

Yes, Linux has two - SCHED_FIFO and SCHED_RR.

	Robert Love

