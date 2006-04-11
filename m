Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDKK6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDKK6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWDKK6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:58:00 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:21889 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750739AbWDKK57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:57:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Tue, 11 Apr 2006 20:57:53 +1000
User-Agent: KMail/1.9.1
References: <200604091944.28954.a1426z@gawab.com> <1144607596.7408.34.camel@homer> <200604101743.17518.a1426z@gawab.com>
In-Reply-To: <200604101743.17518.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112057.53552.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al

On Tuesday 11 April 2006 00:43, Al Boldi wrote:
> After that the loadavg starts to wrap.
> And even then it is possible to login.
> And that's not with the default 2.6 scheduler, but rather w/ spa.

Since you seem to use plugsched, I wonder if you could tell me how does 
current staircase perform with a load like that?

-- 
-ck
