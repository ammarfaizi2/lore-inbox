Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRBEJ1H>; Mon, 5 Feb 2001 04:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRBEJ04>; Mon, 5 Feb 2001 04:26:56 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:2946 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129601AbRBEJ0q>; Mon, 5 Feb 2001 04:26:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A7DF190.C0A3BE83@mail.com> 
In-Reply-To: <3A7DF190.C0A3BE83@mail.com>  <393D1B6D.ECCE0721@mail.com> 
To: Thomas Hood <jdthoodREMOVETHIS@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Shutting down PCMCIA driver in Linux 2.4.1, "Trying to free nonexistent resource <000003e0-000003e1>" 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Feb 2001 09:26:33 +0000
Message-ID: <26472.981365193@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jdthoodREMOVETHIS@mail.com said:
> I get this message when shutting down Linux with 2.4.1 kernel, kernel
> PCMCIA support compiled as a module.

> Trying to free nonexistent resource <000003e0-000003e1>

It's harmless. You can ignore it. It'll be cleaned up, but there are far 
more interesting bugs to squash first :)

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
