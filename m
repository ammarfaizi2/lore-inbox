Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFJTVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFJTVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUFJTVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:21:32 -0400
Received: from s-smtp-osl-02.bluecom.no ([62.101.193.41]:47580 "EHLO
	s-smtp-osl-02.bluecom.no") by vger.kernel.org with ESMTP
	id S262459AbUFJTVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:21:18 -0400
Message-ID: <40C8B4AB.9000800@globelan.net>
Date: Thu, 10 Jun 2004 21:21:15 +0200
From: Lars Age Kamfjord <lakmailing@globelan.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: stian@nixia.no
Subject: Re: timer + fpu stuff locks my console race
References: <40C8AFA4.3040705@globelan.net>
In-Reply-To: <40C8AFA4.3040705@globelan.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Throwing in a ACK on 2.4.18-bf2.4 (debian woody vanilla) from ssh

The guy I crashed probably hates me now, but I warned him last week he 
should give away shellaccounts to everyone he knows.......

Lars Age Kamfjord
BOFH

Lars Age Kamfjord wrote:

> ACK on 2.6.5 (fedora core 2 vanilla)
>
> Totally locked my X window system.
>
> Lars Age Kamfjord
>
> > Please keep me in CC as I'm not on the mailinglist. I'm currently on a
> > vaccation, so I can't hook my linux-box to the Internet, but I came 
> across
> > a race condition in the "old" 2.4.26-rc1 vanilla kernel.
>
> > I'm doing some code tests when I came across problems with my program
> > locking my console (even X if I'm using a xterm).
>
> > I think first of all gcc triggers the problem, so the full report is 
> here:
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905
>
> > Stian Skjelstad
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


