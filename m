Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSDQKju>; Wed, 17 Apr 2002 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313507AbSDQKjt>; Wed, 17 Apr 2002 06:39:49 -0400
Received: from holomorphy.com ([66.224.33.161]:55190 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313505AbSDQKjs>;
	Wed, 17 Apr 2002 06:39:48 -0400
Date: Wed, 17 Apr 2002 03:38:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Artur Brodowski <bzd@astercity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops report (or at least a try to make one)
Message-ID: <20020417103851.GR21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Artur Brodowski <bzd@astercity.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020417122713.404e0cdd.bzd@astercity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 12:27:13PM +0200, Artur Brodowski wrote:
> hello.
> lately i was getting a swapoff error during shutdown, i found out this is
> actually kernel oops message. so i run it thru ksymoops, as said in docs. 
> unfortunately, i have no idea what to do with the output, i'm no hacker.
> first i thought the reason could be that i use nvidia driver, as it gives
> a warning about tainted kernel, but i used it for a while before on the
> same machine/same kernel version, and there were no problems. also, this
> error indicates it's kswapd issue.
> since it's my first attempt to create oops report, i might missed things 
> that are needed for a good info. if so, please give me a chance, don't 
> ignore this mail.

What patches are on top of this? It looks like at least -rmap.


Cheers,
Bill
