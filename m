Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129490AbRBSLDd>; Mon, 19 Feb 2001 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRBSLDY>; Mon, 19 Feb 2001 06:03:24 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:46606 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129490AbRBSLDM>;
	Mon, 19 Feb 2001 06:03:12 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Gérard Roudier <groudier@club-internet.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <d3n1brafoj.fsf@lxplus015.cern.ch> <Pine.LNX.3.96.1010213070337.31857F-100000@mandrakesoft.mandrakesoft.com> <14990.61040.981618.913167@pizda.ninka.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 19 Feb 2001 12:00:34 +0100
In-Reply-To: "David S. Miller"'s message of "Sat, 17 Feb 2001 13:34:40 -0800 (PST)"
Message-ID: <d3vgq7lyy5.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> I think this is an Acenic specific issue.  The second processor
David> on the Acenic board is only there to work around bugs in their
David> DMA controller.

It wasn't put there for that reason. It was intended for better work
;-)

Jes
