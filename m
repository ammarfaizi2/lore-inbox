Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUKBDvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUKBDvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287515AbUKAW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:56:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:24017 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S269430AbUKAVdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:33:51 -0500
Date: Mon, 1 Nov 2004 22:33:46 +0100
From: Pierre <pierre@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: possible GPL violation by Free
Message-ID: <20041101213346.GA5504@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 01 Nov 2004 22:33:46 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When they built the first freebox, I found an inside photo on the net.
> I don't remember which chip it was (several years ago), but it was
> clear
> from the maker that it only supported vxworks. And at this time,
> people
> were already saying it was running linux. There are so many rumors
> about
> many devices running linux that people should check (at least provide
> the
> result of an nmap -O). For most end-users, "linux" is the word for "a
> reliable embedded OS with IP support".

It is certain that the freebox run linux on mips processor [0] :
see the cv of the developper of the freebox [1] [2]
They seem to have done minor contribution [3]

It seem [4] that linux is writen on a flash memory of the freebox with the
firmware of the ADSL modem (if it wasn't how the freebox could connect
throught ADSL for download root and new firmware).

Also it is said that  if you forgot to give
back to them you paid about 300 ??? and it is yours.

I don't know if there is a real GPL violation, but knowing the free support
it will be very difficult to communicate with them...

[0] http://www.idt.com/news/Feb03/02_24_03_1.html
[1] http://alex.krnl.org
[2] http://www.figuiere.net/hub/cv.html
[3] http://www.uclibc.org/lists/uclibc-cvs/2003-January/003068.html
[4] http://www.hifocus.net/freebox3.php3

Deux elements logiciels sont stockees en memoire flash : le noyau linux
et le firmware du chipset Alcatel pour la connexion WAN. Le reste de la
configuration (filtres, logiciels, drivers...) est telecharge a chaque
demarrage et stocke en memoire vive.
