Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRDUXqI>; Sat, 21 Apr 2001 19:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbRDUXp7>; Sat, 21 Apr 2001 19:45:59 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:24075 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133061AbRDUXps>;
	Sat, 21 Apr 2001 19:45:48 -0400
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010421114942.A26415@thyrsus.com> <9bsd33$peb$1@forge.intermeta.de>
From: Jes Sorensen <jes@linuxcare.com>
Date: 22 Apr 2001 01:45:40 +0200
In-Reply-To: "Henning P. Schmiedehausen"'s message of "Sat, 21 Apr 2001 16:38:59 +0000 (UTC)"
Message-ID: <d3itjx24wr.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Henning" == Henning P Schmiedehausen <mailgate@mail.hometree.net> writes:

Henning> "Eric S. Raymond" <esr@thyrsus.com> writes:
>> Here is an example map block for my kxref.py tool:

>> # %Map # T: CONFIG_ namespace cross-reference generator/analyzer #
>> P: Eric S. Raymond <esr@thyrsus.com> # M: esr@thyrsus.com # L:
>> kbuild-devel@kbuild.sourceforge.net # W:
>> http://www.tuxedo.org/~esr/cml2 # D: Sat Apr 21 11:41:52 EDT 2001 #
>> S: Maintained

>> Comments are solicited.

Henning> Hi Eric,

Henning> please not. If you really want to redo this, please use a
Henning> simple XML markup.  Let's not introduce another kind of
Henning> markup if there is already a well distributed and working.

Henning> What's wrong with:

DON'T! go there, please!

A) This sucks to write and maintain, B) it sucks for people bringing
up Linux on a minimum system or new architecture because they don't
want to have to install 217 XML and other tools to just be able to
configure and build a basic kernel.

Jes
