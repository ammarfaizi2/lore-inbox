Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317011AbSFAMjK>; Sat, 1 Jun 2002 08:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSFAMjJ>; Sat, 1 Jun 2002 08:39:09 -0400
Received: from [62.70.58.70] ([62.70.58.70]:60808 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317011AbSFAMjI> convert rfc822-to-8bit;
	Sat, 1 Jun 2002 08:39:08 -0400
Message-Id: <200206011238.g51CcsZ15378@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [BUG] in sendfile() under high load
Date: Sat, 1 Jun 2002 14:38:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206010856290.13503-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since you're doing that testing anyway, do you have profiling enabled? It
> might give you a few pointers.

I have profiling enabled, but can't find any clues of what's using all the 
system time

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
