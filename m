Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316690AbSEQVoW>; Fri, 17 May 2002 17:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316701AbSEQVoV>; Fri, 17 May 2002 17:44:21 -0400
Received: from holomorphy.com ([66.224.33.161]:1197 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316690AbSEQVoV>;
	Fri, 17 May 2002 17:44:21 -0400
Date: Fri, 17 May 2002 14:42:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517214247.GA26374@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Wayne.Brown@altec.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <86256BBC.0072F8A9.00@smtpnotes.altec.com> <3CE572BE.DF2E4406@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 02:14:38PM -0700, Andrew Morton wrote:
> That's you. On May 15 and May 16 I rebuilt the kernel over
> 150 times.

Nice build system.

On Fri, May 17, 2002 at 02:14:38PM -0700, Andrew Morton wrote:
> The deteriorating performance of gcc and the tendency of
> the current build system to needlessly recompile stuff are
> acute problems.  ccache saves me probably one hour per day.

A build on my laptop takes well over an hour. This is not useful
for actually getting things done. I'm all for mitigating build
time in such cases, by kbuild-2.5 and perhaps other methods.


Cheers,
Bill
