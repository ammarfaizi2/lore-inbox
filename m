Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSFGBfj>; Thu, 6 Jun 2002 21:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSFGBfi>; Thu, 6 Jun 2002 21:35:38 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50341 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316194AbSFGBfi>;
	Thu, 6 Jun 2002 21:35:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Johannes Niediek <j.niediek@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPX as module in kernel 2.4.18 has unresolved symbols 
In-Reply-To: Your message of "Thu, 06 Jun 2002 22:58:15 +0200."
             <200206062058.g56KwFX11306@mailgate5.cinetic.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 11:35:31 +1000
Message-ID: <10246.1023413731@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 22:58:15 +0200, 
Johannes Niediek <j.niediek@web.de> wrote:
>I have some trouble with IPX and kernel 2.4.18. I compiled the kernel with IPX-Support as M, but loading the module is not possible and produces the following output:
>
>#>modprobe ipx
>/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol unregister_8022_client_R7acef15d

http://www.tux.org/lkml/#s8-8

