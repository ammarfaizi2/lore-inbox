Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289837AbSAKC0c>; Thu, 10 Jan 2002 21:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289839AbSAKC01>; Thu, 10 Jan 2002 21:26:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:19469 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289837AbSAKC0N>;
	Thu, 10 Jan 2002 21:26:13 -0500
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
From: Robert Love <rml@tech9.net>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20020111004305.99D2F6C3C6@oscar.casa.dyndns.org>
In-Reply-To: <20020111004305.99D2F6C3C6@oscar.casa.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 21:27:49 -0500
Message-Id: <1010716127.1027.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 19:43, Ed Tomlinson wrote:

> The H4 sceduler does not boot here.  The G1 version worked.  The H4 version
> gets as far as:

It seems most people are having problems with the scheduler some time
after G1, at least in UP and 2.4.

Same problem: stops just prior or after 'Starting kswapd' ...

I'll see what changed ...

	Robert Love

