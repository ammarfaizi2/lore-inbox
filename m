Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292869AbSCFBNm>; Tue, 5 Mar 2002 20:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292854AbSCFBN3>; Tue, 5 Mar 2002 20:13:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54539 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292869AbSCFBNO>; Tue, 5 Mar 2002 20:13:14 -0500
Subject: Re: [PATCH] sysevq (kqueue equivalent)
To: tejun@aratech.co.kr
Date: Wed, 6 Mar 2002 01:27:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203061000240.16197-100000@atj.dyndns.org> from "TeJun Huh" at Mar 06, 2002 10:03:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iQDn-00056T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to use to be a real time one, mask it and pull it off the queue when you
> > want. It hands you back the file handle.
> 
>  I don't really see how rt signals work with network i/o multiplexing.
> Can you give me a pointer? Thx in advance.

http://www.zabbo.net/phhttpd/
