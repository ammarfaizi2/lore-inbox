Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310439AbSCPRMD>; Sat, 16 Mar 2002 12:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310440AbSCPRLo>; Sat, 16 Mar 2002 12:11:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310439AbSCPRLb>; Sat, 16 Mar 2002 12:11:31 -0500
Subject: Re: debugging eth driver
To: pmanolov@Lnxw.COM (Petko Manolov)
Date: Sat, 16 Mar 2002 17:27:14 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C92C7D6.4020907@lnxw.com> from "Petko Manolov" at Mar 15, 2002 08:19:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mHxa-0006kH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> upper layer they just disappear.  I passed complete junk to
> the IP layer expecting it to scream, but surprisingly (to me)
> nothing happened.
> 
> How am i supposed to get a feedback from the upper layers?

Keep an eye on /proc/net/snmp

