Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbREEHNq>; Sat, 5 May 2001 03:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbREEHNg>; Sat, 5 May 2001 03:13:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131459AbREEHNV>; Sat, 5 May 2001 03:13:21 -0400
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
To: bergsoft@home.com (Seth Goldberg)
Date: Sat, 5 May 2001 08:17:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF389BD.81F9B398@home.com> from "Seth Goldberg" at May 04, 2001 10:03:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vwJU-0000Ik-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Before I go any further with this investigation, I'd like to get an
> idea
> of how much of a performance improvement the K7 fast_page_copy will give
> me.
> Can someone suggest the best benchmark to test the speed of this
> routine?

About 30% on page copies. Its impact in real world is very dependant on the
job mix

