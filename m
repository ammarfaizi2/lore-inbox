Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSALPeD>; Sat, 12 Jan 2002 10:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287112AbSALPdx>; Sat, 12 Jan 2002 10:33:53 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:60830 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S287111AbSALPdr>; Sat, 12 Jan 2002 10:33:47 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200201121533.g0CFXiG01588@ns.home.local>
Subject: Re: setting up proxy arp with subnetting in 2.4?
To: zengyu1234567@yahoo.com
Date: Sat, 12 Jan 2002 16:33:43 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any method to set the arp proxy entries(with subnetting)
> manually as in 2.2?

Take a look at Julian Anastasov's patches at this URL, you'll find what
you need :

  http://linuxvirtualserver.org/~julian/

Regards,
Willy

