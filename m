Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCZJxw>; Mon, 26 Mar 2001 04:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132394AbRCZJxm>; Mon, 26 Mar 2001 04:53:42 -0500
Received: from t2.redhat.com ([199.183.24.243]:39668 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131158AbRCZJx1>; Mon, 26 Mar 2001 04:53:27 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0103260226440.1589-100000@mara.math.leidenuniv.nl> 
In-Reply-To: <Pine.LNX.4.30.0103260226440.1589-100000@mara.math.leidenuniv.nl> 
To: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
Cc: James Stevenson <mistral@stev.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on /dev/tap0 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 10:52:05 +0100
Message-ID: <11512.985600325@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


buytenh@math.leidenuniv.nl said:
>  Intended behaviour. This is because of the access checks done in the
> netlink code. Misleading, yes. 

I fixed the netlink code so it allowed this to work at one point. Search 
l-k archives for it.

--
dwmw2


