Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272004AbRHVNQj>; Wed, 22 Aug 2001 09:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271999AbRHVNQa>; Wed, 22 Aug 2001 09:16:30 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:8676 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S272000AbRHVNQP>;
	Wed, 22 Aug 2001 09:16:15 -0400
To: <mjacob@feral.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetopia.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010821172532.C23686-100000@wonky.feral.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 22 Aug 2001 15:15:45 +0200
In-Reply-To: Matthew Jacob's message of "Tue, 21 Aug 2001 17:35:50 -0700 (PDT)"
Message-ID: <d3r8u4me0u.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Jacob <mjacob@feral.com> writes:

Matthew> It's not just a question of having firmware updated into
Matthew> flash- which, btw, companies like Veritas have shied away
Matthew> from getting custoemrs to do because you *do* have a small
Matthew> but finite amount of risk updating flash. It's also code that
Matthew> as yet has to be written for qlogicfc (e.g.) that would pull
Matthew> it *out* of flash so it can be pushed into SRAM (which is
Matthew> what the BIOS code on other platforms do).

Yeah vendors tend to like this idea, it's not just Veritas and QLogic
who went down this path, unfortunately.

Updating the flash does seem very easy, and the good thing about the
QLA adapters is that you can reflash even if you screwed up in the
first place. Yup I tried that ;) Writing the flash utility seems like
a piece of cake in this as well. What doesn't look as easy is to
figure out that directory structure of the firmware images ;-( Any
chance you got some data on that?

Cheers,
Jes
