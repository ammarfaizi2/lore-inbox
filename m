Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289186AbSBMXtc>; Wed, 13 Feb 2002 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSBMXtW>; Wed, 13 Feb 2002 18:49:22 -0500
Received: from www.transvirtual.com ([206.14.214.140]:55818 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S289186AbSBMXtG>; Wed, 13 Feb 2002 18:49:06 -0500
Date: Wed, 13 Feb 2002 15:48:43 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Timothy Ball <timball@tux.org>
cc: akpm@zip.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cleanup drivers/char/console.c
In-Reply-To: <20020213234000.GA2538@gwyn.tux.org>
Message-ID: <Pine.LNX.4.10.10202131546361.13382-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following patch cleans up the FLUSH macro used in
> drivers/char/console.c. I haven't made any deep dark changes... just
> added a ";" at the end of the lines where FLUSH is called, cause it
> looked pretty wierd w/o it.

I'm reworking the VT system right now. That macro is going to go away.

