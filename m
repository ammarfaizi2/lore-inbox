Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271074AbRHOHW2>; Wed, 15 Aug 2001 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271075AbRHOHWU>; Wed, 15 Aug 2001 03:22:20 -0400
Received: from mail.fbab.net ([212.75.83.8]:55824 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S271074AbRHOHWC>;
	Wed, 15 Aug 2001 03:22:02 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: viro@math.psu.edu torvalds@transmeta.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.581759 secs)
Message-ID: <3e9f01c1255b$45cf7500$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0108150225120.13928-100000@weyl.math.psu.edu>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 09:24:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander Viro" <viro@math.psu.edu>
>
[snap[crackle[pop]]]
>
> May be memory fragmentation. You need an order 1 allocation for fork(),
just
> to allocate task_struct...
>
>

1) Does that mean i'm screwed (then why, i got about 80 MB free here + 1gb
swap, howto defrag?)

2) I can ssh in as root, why does that still work?

:-)

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


