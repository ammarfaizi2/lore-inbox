Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRC3BuR>; Thu, 29 Mar 2001 20:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRC3BuH>; Thu, 29 Mar 2001 20:50:07 -0500
Received: from gateway.sequent.com ([192.148.1.10]:23572 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S130038AbRC3Bt4>; Thu, 29 Mar 2001 20:49:56 -0500
Date: Thu, 29 Mar 2001 17:45:49 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
Message-ID: <20010329174549.A1264@w-mikek2.sequent.com>
In-Reply-To: <Pine.LNX.4.33.0103291326110.26411-100000@dlang.diginsite.com> <3AC3AF3E.F083EE36@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AC3AF3E.F083EE36@chromium.com>; from fabio@chromium.com on Thu, Mar 29, 2001 at 01:55:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 01:55:11PM -0800, Fabio Riccardi wrote:
> I'm using 2.4.2-ac26, but I've noticed the same behavior with all the 2.4
> kernels I've seen so far.
> 
> I haven't even tried on 2.2
> 
>  - Fabio

Fabio,

Just for fun, you might want to try out some of our scheduler patches
located at:

http://lse.sourceforge.net/scheduling/

I would be interested in your observations.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
