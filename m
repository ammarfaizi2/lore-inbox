Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSC0VPv>; Wed, 27 Mar 2002 16:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSC0VPl>; Wed, 27 Mar 2002 16:15:41 -0500
Received: from zero.tech9.net ([209.61.188.187]:49678 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287862AbSC0VPZ>;
	Wed, 27 Mar 2002 16:15:25 -0500
Subject: Re: Scheduler priorities
From: Robert Love <rml@tech9.net>
To: Wessel Dankers <wsl@fruit.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327202335.GA514@fruit.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Mar 2002 16:14:55 -0500
Message-Id: <1017263732.17510.204.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-27 at 15:23, Wessel Dankers wrote:

> Any plans for a SCHED_IDLE?

I think Ingo Molnar has mentioned lately doing one.

The problem is, it is not easy to implement right - there are priority
inversion issues to deal with ...

	Robert Love

