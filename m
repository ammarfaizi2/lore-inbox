Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSGVWp5>; Mon, 22 Jul 2002 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317880AbSGVWp5>; Mon, 22 Jul 2002 18:45:57 -0400
Received: from [213.4.129.129] ([213.4.129.129]:63635 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id <S317878AbSGVWp5>;
	Mon, 22 Jul 2002 18:45:57 -0400
Date: Tue, 23 Jul 2002 00:49:16 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Karol Olechowski <karol_olechowski@acn.waw.pl>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Athlon XP 1800+ segemntation fault
Message-Id: <20020723004916.28c4af71.diegocg@teleline.es>
In-Reply-To: <1027352789.1655.41.camel@alpha>
References: <20020722133259.A1226@acc69-67.acn.pl>
	<1027341850.31782.16.camel@irongate.swansea.linux.org.uk>
	<1027352789.1655.41.camel@alpha>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc: Internal compiler error:
> program cc1 got fatal signal 11
> make[3] : ***[igmp.o] Error 1

I'm _very_ used to see this in a cyriz 6x86MX 200 Mhz.
And it has only one cause in my system: cpu overhot (well, i let it to
cool a few and restar compiling ;).  ).


and as you've said you have more problems with other operative systems,
then you should check your cooling / check your hardware
