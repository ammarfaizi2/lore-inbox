Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbRGKBeT>; Tue, 10 Jul 2001 21:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbRGKBeJ>; Tue, 10 Jul 2001 21:34:09 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40207 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267178AbRGKBeH>; Tue, 10 Jul 2001 21:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
        linux-mips@oss.sgi.com
Subject: Re: memory alloc failuer : __alloc_pages: 1-order allocation failed.
Date: Wed, 11 Jul 2001 03:37:59 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B4BA24E.1FB614B0@mvista.com>
In-Reply-To: <3B4BA24E.1FB614B0@mvista.com>
MIME-Version: 1.0
Message-Id: <0107110337590G.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 July 2001 02:48, Jun Sun wrote:
> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
>
> I am running 2.4.2 on a linux/mips box, with 32MB system RAM (no
> swap).  When I run a stress test, I will hit memory allocation
> failure:
>
> __alloc_pages: 1-order allocation failed.
> IP: queue_glue: no memory for gluing queue 8108cce0

Next step: install the latest stable kernel and see if the problem 
persists.  (In this case I doubt it will)

--
Daniel
