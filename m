Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSEQErH>; Fri, 17 May 2002 00:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSEQErG>; Fri, 17 May 2002 00:47:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315417AbSEQErG>;
	Fri, 17 May 2002 00:47:06 -0400
Message-ID: <3CE48C08.B0E59851@zip.com.au>
Date: Thu, 16 May 2002 21:50:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: Your message of "Thu, 16 May 2002 19:41:58 MST."
	             <3CE46DF6.62EF67E0@zip.com.au> <E178ZJ8-0001TJ-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Understand?

No.

Are you using a compiler which performs inter-compilation unit
string sharing?

Some explanation of how this works, and of why I should not fill
your ear with toothpaste would be appreciated here.

-
