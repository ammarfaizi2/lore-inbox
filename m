Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHOVcH>; Wed, 15 Aug 2001 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266710AbRHOVb5>; Wed, 15 Aug 2001 17:31:57 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:7488 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S266864AbRHOVbo>; Wed, 15 Aug 2001 17:31:44 -0400
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
From: Georg Nikodym <georgn@somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <29219.997909757@redhat.com>
In-Reply-To: <997905442.2135.6.camel@keller> 
	<997901702.2129.16.camel@keller>   <29219.997909757@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 15 Aug 2001 17:31:55 -0400
Message-Id: <997911115.7088.4.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 2001 22:09:17 +0100, David Woodhouse wrote:

> Apart from the hang on applying or removing power, were you also having 
> this problem with APM suspend?

To be honest, I don't really use suspend/resume so I can't answer.  I
did, however, get it working for myself while at OLS (under 2.4.6-ext3).
The trick there was remove my PCMCIA (3c59x) network card and keep it in
my knapsack for the duration of the conference.

> Strangely, APM suspend was working after a suspend-to-disk. It only failed 
> after a clean boot.

Curious, indeed.

