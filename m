Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269438AbRGaTiC>; Tue, 31 Jul 2001 15:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRGaThw>; Tue, 31 Jul 2001 15:37:52 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:3588 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269440AbRGaThk>;
	Tue, 31 Jul 2001 15:37:40 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107311937.XAA11313@ms2.inr.ac.ru>
Subject: Re: missing icmp errors for udp packets
To: cw@f00f.org (Chris Wedgwood)
Date: Tue, 31 Jul 2001 23:37:06 +0400 (MSK DST)
Cc: therapy@endorphin.org, pekkas@netcore.fi, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010801073441.E8228@weta.f00f.org> from "Chris Wedgwood" at Aug 1, 1 07:34:41 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> ICMP echo/reply is a useful diagnostic tool --- but on the internet as
> we have it today, its limitations need to be understood by the user :)

But what do you propose eventually? :-)

To bind all of them together? Then kernel must be shipped out
without rate-limiting enabled by default, that's problem.

Alexey
