Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSFEWyV>; Wed, 5 Jun 2002 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSFEWyU>; Wed, 5 Jun 2002 18:54:20 -0400
Received: from pc132.utati.net ([216.143.22.132]:20134 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S316496AbSFEWyT>; Wed, 5 Jun 2002 18:54:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 12:55:56 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org> <E17FQPj-0001Rr-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020605232519.D2BB3644@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 10:20 pm, Daniel Phillips wrote:

> Thanks for biting :-)
>
> First, these days it's no big deal to load an entire mp3 into memory.

Ramfs, for example.  The easiest way to pin the sucker in page cache, no 
matter what the VM has to say about it. :)

Rob
