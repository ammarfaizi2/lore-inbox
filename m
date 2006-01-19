Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWASUWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWASUWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWASUWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:22:54 -0500
Received: from mail.linicks.net ([217.204.244.146]:63459 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1161379AbWASUWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:22:53 -0500
From: Nick Warne <nick@linicks.net>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: 2.4.x kernel uptime counter problem
Date: Thu, 19 Jan 2006 20:22:42 +0000
User-Agent: KMail/1.9
Cc: Rumi Szabolcs <rumi_ml@rtfm.hu>, linux-kernel@vger.kernel.org
References: <20060119110834.bb048266.rumi_ml@rtfm.hu> <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com> <20060119201857.GQ7142@w.ods.org>
In-Reply-To: <20060119201857.GQ7142@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601192022.42087.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 20:18, Willy Tarreau wrote:

> > You can use:
> > last -xf /var/run/utmp runlevel
> >
> > to get true uptime in this instance.
> >
> > Nick
>
> I would add that if you need to get valid outputs after such an uptime,
> you can apply the vhz-j64 patch available at Robert Love's (RML) on
> kernel.org.

:-(  Then you would have to start all over again and wait 497.1 days to see if 
it works... :-0

Seriously, is this patch to be added to 2.4.x tree at all in the future?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
