Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314244AbSD0PH4>; Sat, 27 Apr 2002 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSD0PHz>; Sat, 27 Apr 2002 11:07:55 -0400
Received: from holomorphy.com ([66.224.33.161]:15810 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314241AbSD0PHx>;
	Sat, 27 Apr 2002 11:07:53 -0400
Date: Sat, 27 Apr 2002 08:06:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] linux-2.4.19-pre7-rmap13
Message-ID: <20020427150643.GP21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020427085425.GA5573@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 11:54:25AM +0300, Teodor Iacob wrote:
> I got today this: kernel BUG at page_alloc.c:110!
> and then I got this OOPS on a games server running 4 servers of
> hlds/counter-strike:

Any chance you could send me your .config?

Also, was the system running after the first BUG when you got this oops
or is this the oops corresponding to the BUG?


Thanks,
Bill
