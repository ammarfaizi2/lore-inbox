Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSIFQ5u>; Fri, 6 Sep 2002 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319233AbSIFQ5u>; Fri, 6 Sep 2002 12:57:50 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:5898 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318497AbSIFQ5t>; Fri, 6 Sep 2002 12:57:49 -0400
Date: Fri, 6 Sep 2002 19:02:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Marek Mentel <mmark@koala.ichpw.zabrze.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cdrom problem in 2.4.20-pre5-ac1,ac2
Message-ID: <20020906170223.GC1918@louise.pinerecords.com>
References: <200209060945.g869jIk28643@koala.ichpw.zabrze.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209060945.g869jIk28643@koala.ichpw.zabrze.pl>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 11 days, 23:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Repeatable system crash when I am trying to copy
>  files from cdrom  ( tested on different discs - no media errors ) 
>  using  2.4.20-pre5-ac1  or   ac2   .
>    [ full log in attached file ]

Would you mind reading the release notes of the kernel you are using?
This is a known problem with the current IDE code in -ac.
