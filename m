Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbQKJLga>; Fri, 10 Nov 2000 06:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129722AbQKJLgV>; Fri, 10 Nov 2000 06:36:21 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:5415 "EHLO [62.161.177.33]")
	by vger.kernel.org with ESMTP id <S129339AbQKJLgD>;
	Fri, 10 Nov 2000 06:36:03 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: "David S. Miller" <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18pre21
Date: Fri, 10 Nov 2000 12:35:27 +0100
Message-Id: <19341005050711.11931@192.168.1.2>
In-Reply-To: <200011100344.TAA01282@pizda.ninka.net>
In-Reply-To: <200011100344.TAA01282@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o	Resnchronize Apple PowerMac codebase		(Paul Mackerras & co)
>
>BUUUG, new DEV_MAC_HID sysctl number conflicts with DEV_MD
>in Ingo's raid patches.

Well, I beleive DEV_MAC_HID can safely be changed to something else as
userland only use the /proc entry name./

Ben.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
