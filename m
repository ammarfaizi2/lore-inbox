Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293402AbSCPESa>; Fri, 15 Mar 2002 23:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293408AbSCPESU>; Fri, 15 Mar 2002 23:18:20 -0500
Received: from smtp.Lynuxworks.COM ([207.21.185.24]:14354 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S293402AbSCPESQ>; Fri, 15 Mar 2002 23:18:16 -0500
Message-ID: <3C92C7D6.4020907@lnxw.com>
Date: Fri, 15 Mar 2002 20:19:34 -0800
From: Petko Manolov <pmanolov@Lnxw.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020314
X-Accept-Language: en, bg
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: debugging eth driver
In-Reply-To: <20020315.154527.98068496.davem@redhat.com>	<E16m1oW-00057N-00@the-village.bc.nu> <20020315.155748.68123299.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi folks,

I'm playing with an usb-ethernet device and it seems to me
it receive correct frames, but when i pass them to the
upper layer they just disappear.  I passed complete junk to
the IP layer expecting it to scream, but surprisingly (to me)
nothing happened.

How am i supposed to get a feedback from the upper layers?


		Petko

