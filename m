Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbSJEPl6>; Sat, 5 Oct 2002 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSJEPl6>; Sat, 5 Oct 2002 11:41:58 -0400
Received: from f273.law8.hotmail.com ([216.33.240.148]:22536 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262379AbSJEPl5>;
	Sat, 5 Oct 2002 11:41:57 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: bunk@fs.tum.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 compile fails: undef ref in drivers/builtin.o
Date: Sat, 05 Oct 2002 11:47:27 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F2730U1ZG5bTHuICqcD000067ff@hotmail.com>
X-OriginalArrivalTime: 05 Oct 2002 15:47:27.0547 (UTC) FILETIME=[819888B0:01C26C86]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works, or at least compiles.

Thanks for the help.
jay


>From: Adrian Bunk <bunk@fs.tum.de>

>Thanks, this is the well-known problem when you try to compile
>drivers/net/tulip/de2104x.c statically into the kernel. A workaround is to
>compile de2104x modular.
>


_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

