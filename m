Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbRBUPt3>; Wed, 21 Feb 2001 10:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRBUPtT>; Wed, 21 Feb 2001 10:49:19 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:6419 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129192AbRBUPtM>;
	Wed, 21 Feb 2001 10:49:12 -0500
To: Markus Germeier <mager@tzi.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <E14VZCs-00023R-00@the-village.bc.nu> <d3g0h8nou5.fsf@lxplus015.cern.ch> <941yss9m3k.fsf@religion.informatik.uni-bremen.de>
From: Jes Sorensen <jes@linuxcare.com>
Date: 21 Feb 2001 16:48:27 +0100
In-Reply-To: Markus Germeier's message of "21 Feb 2001 14:55:43 +0100"
Message-ID: <d37l2knik4.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Markus" == Markus Germeier <mager@tzi.de> writes:

Markus> Jes Sorensen <jes@linuxcare.com> writes:
>> I only see this for connections with incoming traffic where I don't
>> send something out (like irc), whereas unused ssh connections seem
>> to survive fine.

Markus> Just for the record: My example was an idle ssh connection!

Markus> I believe Alan is correct. I can't remember having this
Markus> problem with another linux box. I'll try to reproduce this
Markus> with a linux box.

Hmmm I am seeing this with Linux boxes at the other end. Haven't tried
talking to non Linux.

Jes
