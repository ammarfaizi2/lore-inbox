Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135832AbRAMCkN>; Fri, 12 Jan 2001 21:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136235AbRAMCjw>; Fri, 12 Jan 2001 21:39:52 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:46090 "EHLO
	earth.su.valinux.com") by vger.kernel.org with ESMTP
	id <S135832AbRAMCjr>; Fri, 12 Jan 2001 21:39:47 -0500
Date: Fri, 12 Jan 2001 19:47:44 -0800
From: Dragan Stancevic <visitor@valinux.com>
To: Dan B <db@cyclonehq.dnsalias.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [eepro100] Ok, I'm fed up now
Message-ID: <20010112194744.A22966@valinux.com>
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com> <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com> <20010111141435.C12616@valinux.com> <5.0.2.1.0.20010112153102.021f34e8@10.0.0.254>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <5.0.2.1.0.20010112153102.021f34e8@10.0.0.254>; from Dan B on Fri, Jan 12, 2001 at 03:32:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001, Dan B <db@cyclonehq.dnsalias.net> wrote:
; Has anyone gotten Intel's (non-GPL) e100 driver working in 2.4.x yet?  What 
; about their e100-ANS driver that supports FEC 800mbps?

I don't think the intels driver is using pci_dma yet so it's
going to take a while before they port all that stuff over,
but than again that is just a guess, maybe they have stuff
done alredy it's just waiting for a new release.



-- 
I knew I was alone, I was scared, it was getting dark and
it was a hardware problem.

                                                -Dragan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
