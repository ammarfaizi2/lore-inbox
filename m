Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRKTXbJ>; Tue, 20 Nov 2001 18:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281163AbRKTXa7>; Tue, 20 Nov 2001 18:30:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281165AbRKTXas>; Tue, 20 Nov 2001 18:30:48 -0500
Subject: Re: New ac patch???
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Tue, 20 Nov 2001 23:38:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111202146260.17569-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 20, 2001 09:47:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166KTa-00036Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to Linus that are 2.5 material (eg PnPBIOS). The only "-ac" patch as such
> > would be for 32bit quota and other oddments so I don't think its worth the
> > effort.
> 
> Will this include the patches to allow for /proc/sys/vm/(min|max)-readahead
> soon?

Thats pretty low on my priority list. Its actually not a hard patch to
extract although I'd prefer someone like Andrea who knows the new rather
undocumented VM did the merge
