Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRBQRky>; Sat, 17 Feb 2001 12:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbRBQRko>; Sat, 17 Feb 2001 12:40:44 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:7377 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S129915AbRBQRk0>;
	Sat, 17 Feb 2001 12:40:26 -0500
Date: Sat, 17 Feb 2001 17:40:11 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Patrick Michael Kane <modus@pr.es.to>
cc: Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <20010217092630.A10934@pr.es.to>
Message-ID: <Pine.SOL.4.21.0102171739240.2241-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Patrick Michael Kane wrote:

> * Pavel Machek (pavel@suse.cz) [010217 05:40]:
> > Being able to remotely resed machine with crashed userland would be
> > *very* nice, too...
> 
> If it provides a true remote console, enable SYSRQ and youi should get this
> for free.

Yes, it should work fine. Of course, there's always the risk you'll
connect to the crashed box from your machine, then hit Alt+SysRq+B, and
say rude things as YOUR machine reboots... :-)


James.

