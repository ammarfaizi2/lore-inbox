Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSCOBBQ>; Thu, 14 Mar 2002 20:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSCOBBG>; Thu, 14 Mar 2002 20:01:06 -0500
Received: from are.twiddle.net ([64.81.246.98]:11654 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S311884AbSCOBAz>;
	Thu, 14 Mar 2002 20:00:55 -0500
Date: Thu, 14 Mar 2002 17:00:49 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020314170049.A25165@twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <E16lTC9-0003uL-00@wagner.rustcorp.com.au> <3C9088F0.8090602@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C9088F0.8090602@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Mar 14, 2002 at 06:26:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 06:26:40AM -0500, Jeff Garzik wrote:
> Will other arches -ever- use the macro?  If not, include/asm-ppc is a 
> better place...

Probably most of them should use it.


r~
