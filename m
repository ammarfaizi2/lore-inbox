Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRHUNbQ>; Tue, 21 Aug 2001 09:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271659AbRHUNbG>; Tue, 21 Aug 2001 09:31:06 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:54246 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271658AbRHUNa5>;
	Tue, 21 Aug 2001 09:30:57 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010821.055856.08326920.davem@redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 Aug 2001 15:31:05 +0200
In-Reply-To: "David S. Miller"'s message of "Tue, 21 Aug 2001 05:58:56 -0700 (PDT)"
Message-ID: <d3elq5a6au.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> Who removed it from the 2.4.x driver recently, and why?

David> I've been playing around, accidently corrupting my firmware a
David> few times, and had to grab the firmware back from older trees
David> to make my qlogic,FC card usable again.

David> Removing the firmware makes no sense, if the firmware was
David> incorrect for some reason, simply correct it.

Alan did after I pointed out to him that it was incompatible with the
GPL (BSD license with advertisement clause). Really hard to fix unless
you get QLogic to change the license for you.

Jes
