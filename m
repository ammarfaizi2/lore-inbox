Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268173AbTAKXWq>; Sat, 11 Jan 2003 18:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268175AbTAKXWq>; Sat, 11 Jan 2003 18:22:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19093
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268173AbTAKXWp>; Sat, 11 Jan 2003 18:22:45 -0500
Subject: Re: 2.4.20 Promise IDE RAID Locks up (gcc 3.2.1!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: freaky <freaky@bananateam.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <006201c2b9ab$668e1950$1400a8c0@Freaky>
References: <006201c2b9ab$668e1950$1400a8c0@Freaky>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042330639.3826.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 00:17:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 19:55, freaky wrote:
> I compiled 2.4.20 on gentoo 1.4rc2 (gcc 3.2.1). When emerging (compiling) X
> my system often gives compile errors which I don't get on the second go, I

See the sig 11 questions in the FAQs on Linux. 99 out of 100 times that
kind of random gcc works, then it doesn't is bad RAM.

