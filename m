Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310186AbSCKXps>; Mon, 11 Mar 2002 18:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310201AbSCKXpj>; Mon, 11 Mar 2002 18:45:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:57809 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S310186AbSCKXp0>; Mon, 11 Mar 2002 18:45:26 -0500
Date: Tue, 12 Mar 2002 01:45:16 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils
Message-ID: <20020311234516.GC128921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4394.1015887380@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394.1015887380@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 09:56:20AM +1100, you [Keith Owens] wrote:
> Content-Type: text/plain; charset=us-ascii
> 
> A double free vulnerability has been found in zlib which can be used in
> a DoS or possibly in an exploit.  Distributions are now shipping
> upgraded versions of zlib, installing the new version of zlib will fix
> programs that use the shared library.

Is there a patch for the kernel ppp zlib implementation available somewhere?
I'd like to patch the kernels I'm running rather than stuffing a random
vendor kernel to the boxes...


-- v --

v@iki.fi
