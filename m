Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130656AbRCEH0L>; Mon, 5 Mar 2001 02:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130658AbRCEH0B>; Mon, 5 Mar 2001 02:26:01 -0500
Received: from www.wen-online.de ([212.223.88.39]:33553 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130655AbRCEHZt>;
	Mon, 5 Mar 2001 02:25:49 -0500
Date: Mon, 5 Mar 2001 08:25:47 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ulrich Kunitz <gefm21@uumail.de>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@vger.kernel.org>
Subject: Re: [PATCH] tiny MM performance and typo patches for 2.4.2
In-Reply-To: <20010304224951.B1979@uumail.de>
Message-ID: <Pine.LNX.4.33.0103050823320.1034-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Mar 2001, Ulrich Kunitz wrote:

> patch-uk2 	makes use of the pgd, pmd and pte quicklists for x86 too;
> 		risky: there might be a reason that 2.4.x doesn't use the
> 		quicklists.

I remember these being taken out (long ago), but not why.  Anyone?

	-Mike

