Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271999AbRHVNST>; Wed, 22 Aug 2001 09:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272002AbRHVNSJ>; Wed, 22 Aug 2001 09:18:09 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:9445 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S272000AbRHVNSA>;
	Wed, 22 Aug 2001 09:18:00 -0400
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZKNa-0000UE-00@the-village.bc.nu> <200108220615.IAA16563@ns.cablesurf.de>
From: Jes Sorensen <jes@sunsite.dk>
Date: 22 Aug 2001 15:17:37 +0200
In-Reply-To: Oliver Neukum's message of "Wed, 22 Aug 2001 08:04:56 +0200"
Message-ID: <d3n14smdxq.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Oliver" == Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:

>> > Oh for the love of God, will you people stop drooling over the
>> fucking > GPL? It's *firmware*... it's just a bunch of bits.  It's
>> *not* a program > the kernel executes.  It's just
>> data. (__init_data to be exact.)
>> 
>> Look, if its not distributable then its no good to anyone.

Oliver> Are you allowed to distribute an initrd that contains it,
Oliver> build from it and GNU tools ?

If you don't violate any of the licenses of the apps you stick on the
initrd. The fact you use GNU tools to build the initrd doesn't really
matter.

The problem with including this in the kernel is that the kernel as a
whole is GPL'ed so including something that is in conflict with the
GPL is kinda problematic.

Cheers
Jes
