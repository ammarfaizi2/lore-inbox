Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281073AbRKDSSL>; Sun, 4 Nov 2001 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281056AbRKDSSC>; Sun, 4 Nov 2001 13:18:02 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:50621 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281064AbRKDSRw>; Sun, 4 Nov 2001 13:17:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 19:20:39 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org>
In-Reply-To: <20011104172742Z16629-26013+37@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160Rpw-0rLDCyC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 November 2001 18:28, Daniel Phillips wrote:
> > It needs special parsers and will be almost impossible to access from
> > shell scripts.
> No, look, he's proposing to put the binary encoding in hidden .files.  The
> good old /proc files will continue to appear and operate as they do now.

But as he already said:
2)  As /proc files change, parsers must be changed in userspace

So if only some programs use the 'dot-files' and the other still use the 
crappy text interface we still have the old problem for scripts, only with a 
much larger effort.

bye...
