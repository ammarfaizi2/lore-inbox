Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290479AbSAYB2s>; Thu, 24 Jan 2002 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290480AbSAYB2i>; Thu, 24 Jan 2002 20:28:38 -0500
Received: from zero.tech9.net ([209.61.188.187]:13843 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290479AbSAYB21>;
	Thu, 24 Jan 2002 20:28:27 -0500
Subject: Re: Q: missing swap in 2.5.2
From: Robert Love <rml@tech9.net>
To: roe jice <jrice@bigidea.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C50B26F.3AC814E6@bigidea.com>
In-Reply-To: <3C50B26F.3AC814E6@bigidea.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 20:33:24 -0500
Message-Id: <1011922405.966.51.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 20:18, roe jice wrote:

>   I compiled 2.5.2 and rebooted and my swap no longer
> works.  swapon returns happy but 'free' show 0 swap
> and /proc/swap is empty.  if i reboot to 2.4.17 swap
> is back.  Since i can't find any like this in the list
> archives i'm guessing it is something i did.
> if anyone could help me i would appreciate it.

Known problem.  Try a 2.5.3-pre.

	Robert Love

