Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283158AbRLDRkp>; Tue, 4 Dec 2001 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282494AbRLDRjK>; Tue, 4 Dec 2001 12:39:10 -0500
Received: from [195.63.194.11] ([195.63.194.11]:11278 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281153AbRLDRhi>; Tue, 4 Dec 2001 12:37:38 -0500
Message-ID: <3C0D077E.59C194B0@evision-ventures.com>
Date: Tue, 04 Dec 2001 18:27:26 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <E16BJ9v-0002ii-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Creating a dependency on Python? Is a non-issue. Current systems that
> > are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> > is nice and it does not create such unmaintainable mess. Whether
> 
> Python2 - which means most users dont have it.

And then you will end with:

python1.4x,
python2,
python3 rewrite in python1 and so on and so on.

Thanks but NO thanks
