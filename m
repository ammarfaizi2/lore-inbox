Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSKRXGy>; Mon, 18 Nov 2002 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSKRXGx>; Mon, 18 Nov 2002 18:06:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24337 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264940AbSKRXFH>;
	Mon, 18 Nov 2002 18:05:07 -0500
Message-ID: <3DD973B6.900@pobox.com>
Date: Mon, 18 Nov 2002 18:11:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tr: make CONFIG_TR depend on CONFIG_LLC=y
References: <20021116111344.GD24641@conectiva.com.br> <1037660711.5785.2.camel@rth.ninka.net>
In-Reply-To: <20021116111344.GD24641@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> On Sat, 2002-11-16 at 03:13, Arnaldo Carvalho de Melo wrote:
>
> >	Please pull from:
> >
> >master.kernel.org:/home/acme/BK/net-2.5
>
>
> Pulled, thanks.



hmmm, did you look at the requirements here?

when I looked at this a couple weeks ago, it did not seem like the best 
fix, just the easiest...

	Jeff



