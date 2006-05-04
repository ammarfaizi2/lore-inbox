Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWEDAVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWEDAVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 20:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEDAVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 20:21:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5080 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750785AbWEDAVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 20:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tdvtu2j59f8qc5grGU1uLZX78Vd9CbRvp7sGCnQKdG6G74AHUJYjmjdOygnO5VVUQ9KlQ6VXoJbYoGooOiWcnh83etUyPmr0imrBsYJRmzvLA9mrldyoHr55vHluOOUgxioKWtlZCP4AbsJJNVumZ2M81uXceQIgAca0hqrMFCw=
Message-ID: <625fc13d0605031721v73cee547l5e067c16f995fd85@mail.gmail.com>
Date: Wed, 3 May 2006 19:21:45 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605031648k56eafc98heb3070e0296dd357@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
	 <6934efce0605031154l225caee8yc217c6e63c0dd441@mail.gmail.com>
	 <625fc13d0605031617v44c2b278kbf12e00781f55ae6@mail.gmail.com>
	 <6934efce0605031648k56eafc98heb3070e0296dd357@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Jared Hulbert <jaredeh@gmail.com> wrote:
> > Erm, why was one built on NAND and one on NOR?  You're comparing
> > apples to oranges now.
>
> The assumption I'm making is that if you don't use XIP that NAND
> becomes an economically attractive and technically feasible option to
> store the code.  The idea was to dive into the tradeoffs of the
> options.  It reflects what I believe is the reality of what design
> decisions are being looked at by customers of my current employer.
>
> Comparing apples and oranges is appropriate when one is investigating
> spherical fruits :)

Heh, ok.  That makes sense if you're investigating the economic options.

josh
