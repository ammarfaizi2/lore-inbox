Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129808AbRBQR0w>; Sat, 17 Feb 2001 12:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129915AbRBQR0l>; Sat, 17 Feb 2001 12:26:41 -0500
Received: from ftp.apple.asimov.net ([209.249.142.209]:21779 "HELO
	isaac.asimov.net") by vger.kernel.org with SMTP id <S129808AbRBQR0b>;
	Sat, 17 Feb 2001 12:26:31 -0500
Date: Sat, 17 Feb 2001 09:26:30 -0800
From: Patrick Michael Kane <modus@pr.es.to>
To: Pavel Machek <pavel@suse.cz>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        James Sutherland <jas88@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
Message-ID: <20010217092630.A10934@pr.es.to>
In-Reply-To: <E14SRPp-0008J1-00@the-village.bc.nu> <3A886F73.759DB067@transmeta.com> <20010214125357.E1931@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010214125357.E1931@bug.ucw.cz>; from pavel@suse.cz on Wed, Feb 14, 2001 at 12:53:57PM +0100
X-Mailer: Mutt http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@suse.cz) [010217 05:40]:
> Being able to remotely resed machine with crashed userland would be
> *very* nice, too...

If it provides a true remote console, enable SYSRQ and youi should get this
for free.
-- 
Patrick Michael Kane
<modus@pr.es.to>
