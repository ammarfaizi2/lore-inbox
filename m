Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292087AbSCKT4I>; Mon, 11 Mar 2002 14:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292294AbSCKT4B>; Mon, 11 Mar 2002 14:56:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:65205 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292178AbSCKTzo>;
	Mon, 11 Mar 2002 14:55:44 -0500
Date: Mon, 11 Mar 2002 14:55:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gunther Mayer <gunther.mayer@gmx.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <Pine.LNX.4.10.10203111140200.10583-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0203111445180.14945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Andre Hedrick wrote:

> Well why did you not object to the SCSI sequencer in the past.
> Your argument proves that hardware venders will not like Linux and the
> childlike additude of not protecting the hardware.  ROOT is a brained
> GAWD that should run for local Politics.

Andre, get a fucking clue.  If you claim that your "filtering" provides
any security - you are making fradulent claims.  End of story.

Fact of life: process with EUID 0 can bypass your "protection" easily.
IF filtering is useful for some reasons, these reasons have nothing to
security.

Again, by mentioning security considerations among the reasons you
are harming yourself - it's kinda hard to take you seriously if you do
not understand the basic stuff.  It's not like we didn't have that
conversation before...

