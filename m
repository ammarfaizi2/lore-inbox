Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290206AbSBKTOJ>; Mon, 11 Feb 2002 14:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290215AbSBKTN7>; Mon, 11 Feb 2002 14:13:59 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:3255 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S290206AbSBKTNs>; Mon, 11 Feb 2002 14:13:48 -0500
Date: Mon, 11 Feb 2002 20:11:08 +0100
From: Kristian <kristian.peters@korseby.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0
Message-Id: <20020211201108.7bc11699.kristian.peters@korseby.net>
In-Reply-To: <Pine.LNX.4.44.0202111849540.17361-100000@netfinity.realnet.co.sz>
In-Reply-To: <20020211172749.2bdadec7.kristian.peters@korseby.net>
	<Pine.LNX.4.44.0202111849540.17361-100000@netfinity.realnet.co.sz>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
> 
> Mikael Pettersson submitted a patch which fixed that for me, its 
> definately in 2.4 mainline. Which kernel is in Debian 3.0?

Hm... That's strange. When I disable serial console on ttyS0 (in inittab) linux will suspend correctly. Although this APIC error on CPU0: 00(40) appears though. Also my one and only fan in my power supply spins down completely. So the box will get quite hot after some minutes in standby mode... Maybe a hardware problem...

Thanks anyway. ;-)

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
