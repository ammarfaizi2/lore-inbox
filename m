Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVEMMRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVEMMRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVEMMRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:17:39 -0400
Received: from alog0338.analogic.com ([208.224.222.114]:51619 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262343AbVEMMRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:17:38 -0400
Date: Wed, 31 Dec 1969 17:54:41 -0500 (EST)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
Message-ID: <Pine.LNX.4.61.6912311752220.4361@chaos.analogic.com>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Srinivas G. wrote:

> Tuesday, January 19 2038. Time: 03:14:07 GMT. If Linux programmers get
> nightmares, it's about this date and time. Immediately after that second
> is crossed, current computer systems running on Linux will grind to a
> halt or go into a loop. This will trip up a lot of databases. No, this
> is not another hoax raised by some anti-Linux lobby. It is Linux's own
> Y2K nightmare, says Businessworld.
>
[SNIPPED...]

It's simply not true. It's more FUD. Look at the date on this email.
Also, calculating 30-year mortgages doesn't use time_t. Code certianly
doesn't set the time 30 years ahead to see what the cost is. It's
just FUD.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
