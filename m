Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSAFQCg>; Sun, 6 Jan 2002 11:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAFQCZ>; Sun, 6 Jan 2002 11:02:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:64526 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288973AbSAFQCJ>;
	Sun, 6 Jan 2002 11:02:09 -0500
Date: Sun, 6 Jan 2002 17:02:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: christian e <cej@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Message-Id: <20020106170204.7e04e81f.skraw@ithnet.com>
In-Reply-To: <3C386DC9.307@ti.com>
In-Reply-To: <3C386DC9.307@ti.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jan 2002 16:31:21 +0100
christian e <cej@ti.com> wrote:

> Hi,all
> 
> You might remember I had issues with massive swapping and wanted to know 
> whether I can control the amount of cache and buffers and so on.Well I 
> thought a mem upgrade would do the trick ,but no :-(
> Not easy to explain to my boss that it still crawls with 512 MB mem and 
> that's the max limit in this laptop..Anyone found any solutions ?? Check 
> this out:

Besides the fact I couldn't identify the kernel version from your mail, I would
try:

1) Turn off swap, then
2) Use 2.4.17 with patch I send you off LKML.

Then give us a hint if things got better.

Regards,
Stephan


