Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbRLTCht>; Wed, 19 Dec 2001 21:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbRLTCh2>; Wed, 19 Dec 2001 21:37:28 -0500
Received: from bexfield.research.canon.com.au ([203.12.172.125]:3761 "HELO
	b.mx.canon.com.au") by vger.kernel.org with SMTP id <S285823AbRLTCh0>;
	Wed, 19 Dec 2001 21:37:26 -0500
Date: Thu, 20 Dec 2001 13:37:05 +1100
From: Cameron Simpson <cs@zip.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220133705.A21648@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com> <20011219171631.A544@burn.ucsd.edu> <20011219.172046.08320763.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.172046.08320763.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 05:20:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 05:20:46PM -0800, David S. Miller <davem@redhat.com> wrote:
|    From: Bill Huey <billh@tierra.ucsd.edu>
|    Like the Java folks ? few and far between ?
| Precisely, in fact.  Anyone who can say that Java is going to be
| relevant in a few years time, with a straight face, is only kidding
| themselves.

Maybe. I'm good at that.

| Java is not something to justify a new kernel feature, that is for
| certain.

Of itself, maybe. (Though an attitude like yours is a core reason Java is
spreading as slowly as it is - much like Linux desktops...)

However, heavily threaded apps regardless of language are hardly likely
to disappear; threads are the natural way to write many many things. And
if the kernel implements threads as on Linux, then the scheduler will
become much more important to good performance.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

Questions are a burden to others,
	Answers, a prison for oneself.
