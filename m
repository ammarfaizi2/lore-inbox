Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269842AbRHSBmH>; Sat, 18 Aug 2001 21:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269848AbRHSBl5>; Sat, 18 Aug 2001 21:41:57 -0400
Received: from are.twiddle.net ([64.81.246.98]:62118 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S269837AbRHSBls>;
	Sat, 18 Aug 2001 21:41:48 -0400
Date: Sat, 18 Aug 2001 18:27:56 -0700
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64
Message-ID: <20010818182756.A29533@twiddle.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <22165.996722560@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22165.996722560@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Aug 02, 2001 at 01:22:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:22:40PM +1000, Keith Owens wrote:
> Using BFD is the only way I can handle all
> the relocation types, especially in cross compile mode.

What the hell?  You've got everything you need right there in 
the obj subdirectory.  Please don't bring libbfd back to life
in modutils.


r~
