Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSK1QRe>; Thu, 28 Nov 2002 11:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSK1QRd>; Thu, 28 Nov 2002 11:17:33 -0500
Received: from pat.uio.no ([129.240.130.16]:54732 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265568AbSK1QRd>;
	Thu, 28 Nov 2002 11:17:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15846.17236.556847.267054@charged.uio.no>
Date: Thu, 28 Nov 2002 17:24:52 +0100
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <Pine.LNX.4.44.0211280930530.1818-100000@grignard.amagerkollegiet.dk>
References: <shsptsq4oy9.fsf@charged.uio.no>
	<Pine.LNX.4.44.0211280930530.1818-100000@grignard.amagerkollegiet.dk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:

     > I assume, you mean rc4 and not pre4?

     > Both client and server now running 2.4.20-rc4, but
     > unfortunately this does not solve the problem:

Is that a 'clean' rc4, with no extra patches, no memory-corrupting
Nvidia modules loaded or anything suspicious like that?
'cos I'm completely incapable of reproducing anything like what you
are seeing.

Does it also occur if you play around with setting rsize and wsize =
1024?

Cheers,
  Trond
