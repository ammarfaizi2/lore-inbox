Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTE2BH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTE2BH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:07:58 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:5808 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261798AbTE2BH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:07:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Date: Thu, 29 May 2003 11:22:20 +1000
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305291122.20775.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 10:55, Marcelo Tosatti wrote:
> Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's fix
> for the IO stalls/deadlocks.

Good for you. Well done Marcelo!

> Please test it.

Yes everyone who gets these stalls please test it also!

> Andrew Morton <akpm@digeo.com>:
>   o Fix IO stalls and deadlocks

For those interested these are patches 1 and 2 from akpm's proposed fixes in 
the looong thread discussing this problem.

Con
