Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271696AbRHQRal>; Fri, 17 Aug 2001 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRHQRa3>; Fri, 17 Aug 2001 13:30:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25098 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271696AbRHQRaO>; Fri, 17 Aug 2001 13:30:14 -0400
Date: Fri, 17 Aug 2001 14:30:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: <tpepper@vato.org>, <f5ibh@db0bm.ampr.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <20010816.153151.74749641.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0108171430000.2277-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, David S. Miller wrote:
>    From: tpepper@vato.org
>    Date: Thu, 16 Aug 2001 14:41:09 -0700
>
>    Confirmed here.  Looks like a pretty obvious goof to me.  Does the following
>    fix it for you?
>
> The args and semantics of min/max changed to take
> a type first argument, the problem with this ntfs file is that it
> fails to include linux/kernel.h

You should have checked this before deciding to rudely
bypass the maintainer of the file ;)

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

