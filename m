Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131017AbQKUUlD>; Tue, 21 Nov 2000 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbQKUUky>; Tue, 21 Nov 2000 15:40:54 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:32007 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131017AbQKUUkt>;
	Tue, 21 Nov 2000 15:40:49 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deadlock on 4way machine
In-Reply-To: <Pine.LNX.4.21.0011211932260.1463-100000@penguin.homenet>
From: Jes Sorensen <jes@linuxcare.com>
Date: 21 Nov 2000 21:10:41 +0100
In-Reply-To: Tigran Aivazian's message of "Tue, 21 Nov 2000 19:35:09 +0000 (GMT)"
Message-ID: <d3snol9jcu.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tigran" == Tigran Aivazian <tigran@veritas.com> writes:

Tigran> Hi, Some processes get stuck in page fault handler for ages
Tigran> (like for 10 minutes!). The machine still has plenty (3.5G) of
Tigran> free high memory but zero (2216K) of free low memory.

Including info on the kernel version would kinda help.

Could you also try to reproduce it without including any binary only
proprietary kernel modules?

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
