Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbSAZSLC>; Sat, 26 Jan 2002 13:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSAZSKj>; Sat, 26 Jan 2002 13:10:39 -0500
Received: from ns.suse.de ([213.95.15.193]:262 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285935AbSAZSKe>;
	Sat, 26 Jan 2002 13:10:34 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: question about sparc 64-bit user land
In-Reply-To: <20020126171545.GB11344@fefe.de>
From: Andreas Jaeger <aj@suse.de>
Date: Sat, 26 Jan 2002 19:07:04 +0100
In-Reply-To: <20020126171545.GB11344@fefe.de> (Felix von Leitner's message
 of "Sat, 26 Jan 2002 18:15:45 +0100")
Message-ID: <u87kq5vvef.fsf@gromit.moeb>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <usenet-20020126@fefe.de> writes:

> My understanding is that there is no 64-bit user land support for
> UltraSPARC, although the kernel runs in 64-bit mode.  Is that correct?
> If yes: why is that (still) so?

There is Sparc64 userland - but only very few people use it.  glibc
and binutils are ready but for compilation you should use a GCC 3.1
CVS version.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
