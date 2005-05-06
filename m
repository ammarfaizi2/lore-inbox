Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVEFQg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEFQg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 12:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 12:35:24 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:61405
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261218AbVEFQeo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 12:34:44 -0400
Date: Fri, 6 May 2005 17:34:41 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 apparently locked with xscreensaver, 2.6.11.7
In-Reply-To: <Pine.LNX.4.58.0505061625250.23675@ppg_penguin.kenmoffat.uklinux.net>
Message-ID: <Pine.LNX.4.58.0505061731130.23961@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0505061625250.23675@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Ken Moffat wrote:

>
>  Any suggestions on debugging this ?
>

Forgot to post the ver_linux.

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bluesbreaker 2.6.11.7-k832-1 #1 Thu Apr 21 15:34:05 BST 2005 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      6.0.3
Procps                 3.2.5
Kbd                    1.12
Sh-utils               5.2.1
udev                   056
Modules Loaded         via_velocity crc_ccitt

-- 
 das eine Mal als Tragödie, das andere Mal als Farce

