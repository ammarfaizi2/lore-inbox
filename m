Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278445AbRJOVbM>; Mon, 15 Oct 2001 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRJOVbB>; Mon, 15 Oct 2001 17:31:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25862 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278445AbRJOVaw>; Mon, 15 Oct 2001 17:30:52 -0400
Subject: Re: System Hang with Gigabit Ethernet
To: fant@vpharm.com
Date: Mon, 15 Oct 2001 22:37:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011015135310.fant@vpharm.com> from "Andrew Fant" at Oct 15, 2001 01:53:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tFQB-0003Ro-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the kernel version is 2.2.14 ( Upgrading is not a particularly pleasant option, as I
> don't know if I could recreate the changes that RedHat made to the kernel for the
> Enterprise Edition).  Because the system must now be multihomed between two mutually

Actually I think all the bits you probably care about are in Andrea's
patches to 2.2 now, and in the base 2.4. Red Hat 7.1 is also validated for
Oracle 9i

(mostly content free press release on that [sorry I dont have a technical 
 URL for it) -> http://www.redhat.com/about/presscenter/2001/press_oracle.html
