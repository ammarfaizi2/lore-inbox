Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSHGNHo>; Wed, 7 Aug 2002 09:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSHGNGg>; Wed, 7 Aug 2002 09:06:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47243 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317141AbSHGNGd>;
	Wed, 7 Aug 2002 09:06:33 -0400
Date: Wed, 7 Aug 2002 14:36:22 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:113!
Message-Id: <20020807143622.597f1723.stephane.wirtel@belgacom.net>
In-Reply-To: <Pine.LNX.4.44L.0208070106110.23404-100000@imladris.surriel.com>
References: <20020807034831.2fa1823f.stephane.wirtel@belgacom.net>
	<Pine.LNX.4.44L.0208070106110.23404-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

without this module, i don't have this problem.

certainly an error of NVidia developpers.

thanks you

Stéphane Wirtel


On Wed, 7 Aug 2002 01:07:32 -0300 (BRT)
Rik van Riel <riel@conectiva.com.br> wrote:

> On Wed, 7 Aug 2002, Stephane Wirtel wrote:
> 
> > nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
> 
> > kernel BUG at page_alloc.c:113!
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c012ed6e>]    Tainted: P
>                                ^^^^^^^^^^
> 
> Can you trigger this bug without having the nvidia driver
> write all over memory ?
> 
> Rik
> -- 
