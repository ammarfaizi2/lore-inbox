Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBNGsb>; Wed, 14 Feb 2001 01:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130644AbRBNGsL>; Wed, 14 Feb 2001 01:48:11 -0500
Received: from smtp1.free.fr ([212.27.32.5]:2832 "EHLO smtp1.free.fr")
	by vger.kernel.org with ESMTP id <S129154AbRBNGr7>;
	Wed, 14 Feb 2001 01:47:59 -0500
To: linux-kernel@vger.kernel.org
Subject: incremental patches for 2.4*-ac* kernels
Message-ID: <982133270.3a8a2a1644394@imp.free.fr>
Date: Wed, 14 Feb 2001 07:47:50 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.55.157
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think that most of us using modems begin to experience a little pain in
downloading latest Alan's patches since they're becoming to be really big (and
interesting).

Since I have an occasionnal access to a system equipped with a good line, I
began to make incremental patches for these kernels. These patches are about
60 kb instead of nearly 2 Mb. Those who are interested can download them from
this url :

   http://www-miaif.lip6.fr/willy/pub/linux-patches/ac/

Of course, they are not signed nor official, and people who want to use them
for production would better get them from the official sites.

At the moment, only ac9-to-ac10 and ac10-to-ac12 are provided.

To use them :
- extract official linux-2.4.1
- apply one of Alan's patches (acXX)
- apply one of these incremental patches (acXX-acYY)
-> you'll get a 2.4.1-acYY


Hope this will help people to test and report bugs.

Cheers,
Willy
