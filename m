Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSC0UYJ>; Wed, 27 Mar 2002 15:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSC0UXt>; Wed, 27 Mar 2002 15:23:49 -0500
Received: from 68dyn61.com21.casema.net ([213.17.72.61]:64412 "HELO
	fruit.eu.org") by vger.kernel.org with SMTP id <S310139AbSC0UXh>;
	Wed, 27 Mar 2002 15:23:37 -0500
Date: Wed, 27 Mar 2002 21:23:35 +0100
From: Wessel Dankers <wsl@fruit.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler priorities
Message-ID: <20020327202335.GA514@fruit.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020327125828.U2343-100000@angelina.sl.pt> <1017236512.16546.116.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-03-27 08:41:51-0500, Robert Love wrote:
> On Wed, 2002-03-27 at 08:06, Nuno Miguel Rodrigues wrote:
> 
> > Indeed.  In other words a priority that is not dynamically adjusted over
> > time.  Like a real-time scheduling priority.
> 
> Yes, Linux has two - SCHED_FIFO and SCHED_RR.

Any plans for a SCHED_IDLE?

--
Wessel Dankers <wsl@fruit.eu.org>

