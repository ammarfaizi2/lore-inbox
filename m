Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRHUPbV>; Tue, 21 Aug 2001 11:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271720AbRHUPbL>; Tue, 21 Aug 2001 11:31:11 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:40895 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271719AbRHUPbA>;
	Tue, 21 Aug 2001 11:31:00 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <no.id> <E15ZCmV-00080q-00@the-village.bc.nu> <20010821.074720.118955855.davem@redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 Aug 2001 17:29:37 +0200
In-Reply-To: "David S. Miller"'s message of "Tue, 21 Aug 2001 07:47:20 -0700 (PDT)"
Message-ID: <d3ofp98m8u.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Alan Cox <alan@lxorguk.ukuu.org.uk> Date: Tue, 21 Aug
David> 2001 15:45:26 +0100 (BST)
   
>    Ok so you have a sparc specific firmware loading problem.

David> No, it is a non-x86 firmware loading problem.  Do not label it
David> is as a "all the world a Sparc" problem, it isn't centric to
David> any particular platform.

It's centric to a limited userbase, other systems such as Alpha and
ia64 can load the firmware off the cards no problem.

Doesn't mean we have solved your problem, true. But initrd is still a
cleaner solution and gets around the licensing problem as well.

Jes
