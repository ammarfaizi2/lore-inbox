Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRKQWca>; Sat, 17 Nov 2001 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKQWcU>; Sat, 17 Nov 2001 17:32:20 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:2835 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281806AbRKQWcF>; Sat, 17 Nov 2001 17:32:05 -0500
Message-ID: <3BF6E539.7E492A82@zip.com.au>
Date: Sat, 17 Nov 2001 14:31:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>, <20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com> <3BF6E039.923E0577@zip.com.au>,
		<3BF6E039.923E0577@zip.com.au> <20011117142326.I21354@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Can ext2resize change the block size too?

Nope.  Block size is rather fundamental.
