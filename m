Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311625AbSCNOUY>; Thu, 14 Mar 2002 09:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311626AbSCNOUO>; Thu, 14 Mar 2002 09:20:14 -0500
Received: from smtp.intrex.net ([209.42.192.250]:58123 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S311625AbSCNOUM>;
	Thu, 14 Mar 2002 09:20:12 -0500
Date: Thu, 14 Mar 2002 09:24:16 -0500
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
Message-ID: <20020314092416.A1557@tricia.dyndns.org>
In-Reply-To: <3C902631.3A406D51@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C902631.3A406D51@kegel.com>; from dank@kegel.com on Wed, Mar 13, 2002 at 08:25:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 08:25:21PM -0800, Dan Kegel wrote:

> While I await his constructive response, perhaps I'll get my 
> glibc patch in shape.
> I am maintainer of what amounts to a tiny embedded linux
> distribution, and I'm pretty sure my users would like
> gprof to work.  (In fact, my boss's boss would really
> like gprof to work.  This problem has a lot of visibility.)

Does gprof work with dynamically loaded libraries?  I remember trying to
get it to work with mozilla and if I remember correctly it would not
work because mozilla used threads and it dlopen()ed things.

Thanks,

Jim
