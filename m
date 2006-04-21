Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWDUPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWDUPPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDUPPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:15:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:51094 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932350AbWDUPPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:15:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=AtXtSxVJOiA7RUE7hpNtPXqkhQWRqLaiL8F6O2HvSHszLCHdAwgY89AVo81G+ZzYeri7o2S/3RpSGXFyPBeLyNNLeOhgC3jz1jVyJbz3Lx/q/azuoiNF1hBYdx4AJZSifMIQBBDx5pmSzOWW5EpyL2qBqd0H2qmI47hgFoMhApc=
Message-ID: <4448F890.60403@gmail.com>
Date: Fri, 21 Apr 2006 22:21:52 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Mike Galbraith <efault@gmx.de>, Hua Zhong <hzhong@gmail.com>,
       Patrick McHardy <kaber@trash.net>, Michael Buesch <mb@bu3sch.de>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com> <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr> <44481ACE.9040104@gmail.com> <44482963.4030902@trash.net> <Pine.LNX.4.61.0604211447310.23180@yvahk01.tjqt.qr> <Pine.LNX.4.61.0604211452160.23180@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604211452160.23180@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I found that "Fireflier" acts like ipt_owner. But I haven't tested it
with this "swapper problem"

[1] - http://edwintorok.googlepages.com/fireflier_kernel.html
[2] - http://fireflier.isgeeky.com/wiki/What_is_fireflier
[3] - http://fireflier.isgeeky.com/wiki/Kernel_module
[4] - http://fireflier.isgeeky.com/wiki/Features

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPiQNWc9T2Wr2JcRAlPkAKCfZzgQAmWRBcmMJ3fcNQ2KkP2aEQCgu9q4
8gBeU287DTt17l4q+kSq1A4=
=iyjA
-----END PGP SIGNATURE-----
