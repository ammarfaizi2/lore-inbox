Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSAZHrj>; Sat, 26 Jan 2002 02:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSAZHra>; Sat, 26 Jan 2002 02:47:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:43793 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288949AbSAZHrQ>; Sat, 26 Jan 2002 02:47:16 -0500
Message-ID: <3C525D7B.EDAC966A@zip.com.au>
Date: Fri, 25 Jan 2002 23:40:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stock 2.4.18-pre6 vs low latency
In-Reply-To: <3C525BA0.1050405@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> 2.4.18-pre6 + lowlat
> -----------------------
> 0.0 8580075
> 0.1 13384
> 0.2 350
> 0.3 167
> 0.4 54
> 0.5 7
> 0.6 5
> 0.7 3
> 0.8 1
> 2.7 1

OK (ish)

> 33.6 1

Very not OK.  Is this repeatable?

-
