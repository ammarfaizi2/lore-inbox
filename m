Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285342AbRLNMdz>; Fri, 14 Dec 2001 07:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285357AbRLNMdp>; Fri, 14 Dec 2001 07:33:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62867 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285342AbRLNMdc>;
	Fri, 14 Dec 2001 07:33:32 -0500
Date: Fri, 14 Dec 2001 15:30:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Paulo Schreiner <paulo@bewnet.com.br>
Cc: J Sloan <jjs@lexus.com>, Linux kernel <linux-kernel@vger.kernel.org>,
        tux-list <tux-list@redhat.com>
Subject: [-D5] Re: TUX 2
In-Reply-To: <3C190628.7010802@bewnet.com.br>
Message-ID: <Pine.LNX.4.33.0112141527560.9494-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded the latest, 2.4.16-D5 TUX patch, which now compiles with
your .config:

    http://redhat.com/~mingo/TUX-patches/tux2-full-2.4.16-final-D5.bz2

for the latest TUX patches you'll also need the 2.1.1-10 version of the
TUX utilities:

    http://redhat.com/~mingo/TUX-patches/tux-2.1.1.tar.gz

let me know if there are still any compilation/linking (or other)
problems,

	Ingo

