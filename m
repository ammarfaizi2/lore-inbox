Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRKDVkc>; Sun, 4 Nov 2001 16:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRKDVkX>; Sun, 4 Nov 2001 16:40:23 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:9410 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278078AbRKDVkL>; Sun, 4 Nov 2001 16:40:11 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Tim Jansen <tim@tjansen.de>
To: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 22:42:54 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011104204502.O14001@unthought.net> <200111042112.fA4LCNR241720@saturn.cs.uml.edu> <20011104222009.Y14001@unthought.net>
In-Reply-To: <20011104222009.Y14001@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <160Uzc-1RQC4OC@fmrl03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 22:20, Jakob Østergaard wrote:
> > > I could even live with parsing ASCII, as long as there'd just be type
> > > information to go with the values.
> > You are looking for something called the registry. It's something
> > that was introduced with Windows 95. It's basically a filesystem
> > with typed files: char, int, string, string array, etc.
> Having read out 64 bit values, floating point data etc. from the registry,
> I'm old enough to know that it is *NOT* what I'm looking for   :)

Why? It's not bad only because it is from MS. IMHO the disadvantages of the 
registry are:
- you need special software/syscalls to access it
- because of that making backups etc is hard
- the organization of the data is horrible

Assuming you could mount it as a regular filesystem and use it for kernel 
configuration, what else are its disadvantages?

bye...



