Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRLDSTM>; Tue, 4 Dec 2001 13:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283208AbRLDSSs>; Tue, 4 Dec 2001 13:18:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37381 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283141AbRLDSSY>; Tue, 4 Dec 2001 13:18:24 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: trini@kernel.crashing.org (Tom Rini)
Date: Tue, 4 Dec 2001 18:26:27 +0000 (GMT)
Cc: dalecki@evision.ag, alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org, hch@caldera.de (Christoph Hellwig),
        esr@thyrsus.com (Eric S. Raymond), kaos@ocs.com.au (Keith Owens),
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <20011204181337.GL17651@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Dec 04, 2001 11:13:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BKGx-0002y5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Python2 - which means most users dont have it.
> 
> Most users sure as hell shouldn't be playing with 2.5.x right now
> anyways.  With any sort of 'luck' it'll be 6 months at least before
> 2.5.x becomes stable enough that it will probably compile all the time
> again and not have a random fs eating bug.  In 6 months even woody might
> be frozen :)

It wont become stable if nobody can configure it because nobody will build
it or run it. Lots of people build non stable kernels because its

a) fun
b) a way to learn and play with the system
c) they might make their own small fix and mark

not all of the them are demon kernel hackers.

Alan
