Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288865AbSAEQwx>; Sat, 5 Jan 2002 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288867AbSAEQwn>; Sat, 5 Jan 2002 11:52:43 -0500
Received: from ns01.netrox.net ([64.118.231.130]:31122 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S288865AbSAEQwa>;
	Sat, 5 Jan 2002 11:52:30 -0500
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C36B112.5A533652@mvista.com>
In-Reply-To: <Pine.LNX.4.33.0201041238350.2247-100000@localhost.localdomain>
	<200201050031.g050V7217956@mailf.telia.com>  <3C36B112.5A533652@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 05 Jan 2002 11:54:04 -0500
Message-Id: <1010249648.1986.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-05 at 02:53, george anzinger wrote:

> The two patches will are not compatable.  When the time comes we will
> have to work out how to make them compatable as they both modify key
> parts of sched.c.

Ingo and I are working on a merged patchset that works.  Yay.

	Robert Love

