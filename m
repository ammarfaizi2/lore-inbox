Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJCMGH>; Thu, 3 Oct 2002 08:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263248AbSJCMGH>; Thu, 3 Oct 2002 08:06:07 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:5872 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261206AbSJCMGG>; Thu, 3 Oct 2002 08:06:06 -0400
Subject: Re: O(1) scheduler for 2.4.(19|20-pre.)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210031148.23823.roy@karlsbakk.net>
References: <200210031148.23823.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 13:19:04 +0100
Message-Id: <1033647544.28022.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 10:48, Roy Sigurd Karlsbakk wrote:
> 1. Do I need the O(1) scheduler to run a heavily I/O bound server application 
> with some 200-500 concurrent threads?
> 2. If so - can I find the O(1) scheduler somewhere for 2.4?

2.4.19-ac/2.4.20-ac, Red Hat 7.3, Red Hat 8.0, and probably quite a few
other places. I think Robert had a set of patches versus plain 2.4.19
too

