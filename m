Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVGTNFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVGTNFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGTNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:05:22 -0400
Received: from [194.90.237.34] ([194.90.237.34]:20122 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261194AbVGTNFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:05:21 -0400
Date: Wed, 20 Jul 2005 16:07:42 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-ID: <20050720130742.GK25957@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050711145616.GA22936@mellanox.co.il> <9a87484905072005596f2c2b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a87484905072005596f2c2b51@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Jesper Juhl <jesper.juhl@gmail.com>:
> > static struct foo *foo_bar(struct foo *first, struct bar *second,
> >                            struct foobar* thirsd);
> > 
> In this example you are not consistently placing your *'s, "struct foo
> *first" vs "struct foobar* thirsd". Common practice is "struct foo
> *first".

Doh. Right. Thanks!

-- 
MST
