Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUHOLCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUHOLCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUHOLCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:02:25 -0400
Received: from server133-han.de-nserver.de ([81.3.17.173]:47237 "EHLO
	server133-han.de-nserver.de") by vger.kernel.org with ESMTP
	id S266585AbUHOLCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:02:19 -0400
Date: Sun, 15 Aug 2004 12:57:07 +0200
From: markus reichelt <mr@lists.notified.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usb mouse completely ignored by 2.6.8.1
Message-ID: <20040815105707.GA2359@lists.notified.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <411E40F2.6000000@yahoo.co.jp> <411E4D15.9080708@yahoo.co.jp> <411E5A88.5040402@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <411E5A88.5040402@yahoo.co.jp>
Organization: still stuck in reorganization mode
X-Request-PGP: http://lists.notified.de/pubkey.mr.lists.asc
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tetsuji Rai <badtrans666@yahoo.co.jp> wrote:
> I solved this problem by myself.   I had been using a USB mouse and a PS/2
> keyboard.   After I switched my mouse to PS/2 mode and disabled usb mouse
> support in BIOS, then 2.6.8 accepts my keyboard input.   It's good for me,
> but it will affect people having only usb keyboards and mice...

Exactly :(

I'm writing this on an asus m2400n and I can't get a plain usb mouse
to work with 2.6.8.1. That sucks big time! So it's back to 2.6.8-rc3 for me. 

A fix to this would be greatly appreciated. And I really hope ppl
will get it right again with the next stable release!  


- -- 
Bastard Administrator in $hell

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBH0GDLMyTO8Kj/uQRAriJAJ93QNp5MR6Mx1KhTslbK56tbHt4BwCfal9W
UVSUQpApL0JO7tBQInS8G7Q=
=SMC0
-----END PGP SIGNATURE-----
