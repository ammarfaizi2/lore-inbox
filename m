Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTA3Jnh>; Thu, 30 Jan 2003 04:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTA3Jnf>; Thu, 30 Jan 2003 04:43:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64470 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267455AbTA3Jne>; Thu, 30 Jan 2003 04:43:34 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301300952.h0U9qof06935@devserv.devel.redhat.com>
Subject: Re: Morse code on keyboard LEDs
To: john@grabjohn.com (John Bradford)
Date: Thu, 30 Jan 2003 04:52:50 -0500 (EST)
Cc: davej@codemonkey.org.uk (Dave Jones), szepe@pinerecords.com,
       linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <200301292003.h0TK3jlW002390@darkstar.example.net> from "John Bradford" at Jan 29, 2003 08:03:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That was never included in mainline, and only exists in Alans tree afaik.
> 
> Alan - Is there any reason why that can't go in to mainline, (apart from the
> feature melt^Wfreeze)?

I'm all for it going mainline. For 2.4 it always seemed to be useful but
trivial so probably not an appropriate mainstream item, for 2.5 I'd like to
see it in.

