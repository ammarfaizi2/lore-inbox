Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278908AbRKMUsF>; Tue, 13 Nov 2001 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278927AbRKMUrz>; Tue, 13 Nov 2001 15:47:55 -0500
Received: from freeside.toyota.com ([63.87.74.7]:52751 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S278908AbRKMUrk>; Tue, 13 Nov 2001 15:47:40 -0500
Message-ID: <3BF186DD.A71B796D@lexus.com>
Date: Tue, 13 Nov 2001 12:47:25 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kees <kees@schoen.nl>
CC: J Sloan <jjs@toyota.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: report: tun device
In-Reply-To: <Pine.LNX.4.33.0111132131330.29497-100000@schoen3.schoen.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:

> Hi,
>
> I referred to KERNEL 2.4.14 with patch-2.4.15pre3
>
> I did recompile vtund AFTER my new kernel installment and startup and it
> didn't help.
> I traced vtund and it opens /dev/net/tun
> the ioctl call after it returns the error

Yes, but the big questions remained unanswered:

1. What version of vtund are you running?
2. Under what kernel did vtund last work?

cu

jjs

