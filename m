Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbRFYPpE>; Mon, 25 Jun 2001 11:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264650AbRFYPoo>; Mon, 25 Jun 2001 11:44:44 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:36356 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264640AbRFYPoc>;
	Mon, 25 Jun 2001 11:44:32 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Pete Wyckoff <pw@osc.edu>, nick@snowman.net, Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net> <Pine.LNX.4.21.0106141739140.16013-100000@ns> <15145.12192.199302.981306@pizda.ninka.net> <20010615111213.C2245@osc.edu> <15146.11179.315190.615024@pizda.ninka.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 25 Jun 2001 17:42:59 +0200
In-Reply-To: "David S. Miller"'s message of "Fri, 15 Jun 2001 08:37:15 -0700 (PDT)"
Message-ID: <d366dkefb0.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Pete Wyckoff writes:
>> We're currently working on using both processors of the Tigon in
>> parallel.

David> It is my understanding that on the Tigon2, the second processor
David> is only for working around hw bugs in the DMA controller of the
David> board and cannot be used for other tasks.

Actually it was intended to be used for other stuff but they ended up
having to use it for workarounds.

Jes
