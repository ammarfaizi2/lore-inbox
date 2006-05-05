Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWEEAKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWEEAKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWEEAKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:10:47 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:7879 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932405AbWEEAKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=re0GCma+n5lEiNhh8chrDG0oDmguETJCvJWSaEWxfpc0W6dNMbyuknlUDzEy8/4DC2Zu6LMPFg1EkCWRGKqU4yyg7jRRA9PBmn3EIakKtLv6IsBDWVLo1T/tzM2Ni9U7d9BTF9FZcbqUNx1gjmXZjYJqvPWkl0Tpq7AROfvojG4=
Message-ID: <bda6d13a0605041710v480b4c0ci999fcf4b0cffa1b@mail.gmail.com>
Date: Thu, 4 May 2006 17:10:46 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Joshua Hudson" <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
In-Reply-To: <20060504204708.GC22880@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
	 <1146750532.20677.38.camel@localhost.localdomain>
	 <20060504165055.GA22880@animx.eu.org>
	 <1146762658.22308.11.camel@localhost.localdomain>
	 <bda6d13a0605041027kc0edb02icdd11bd103478b05@mail.gmail.com>
	 <20060504204708.GC22880@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Wakko Warner <wakko@animx.eu.org> wrote:
> Joshua Hudson wrote:
> > I've seen this a few times. It never actually hung my system, only one
> > virtual console. I wonder if preemptable kernel had something to do
> > with that <g>
>
> I don't believe pre-empt has anything to do eith it.  I have a specialized
> boot system (vairous types of boot media) w/o preempt turned on because I
> want this as small as possible.  It also has this problem.

Uuhhh. I though preempt might be the reason the who system *wasn't* hanging.
