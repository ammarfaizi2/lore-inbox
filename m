Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSFDVlQ>; Tue, 4 Jun 2002 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316844AbSFDVlP>; Tue, 4 Jun 2002 17:41:15 -0400
Received: from mons.uio.no ([129.240.130.14]:4773 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316843AbSFDVlJ>;
	Tue, 4 Jun 2002 17:41:09 -0400
To: Tim Hockin <thockin@hockin.org>
Cc: kloczek@rudy.mif.pg.gda.pl (Tomasz =?iso-8859-2?q?K=B3oczko?=),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        austin@coremetrics.com (Austin Gonyou),
        linux-kernel@vger.kernel.org (Linux Kernel List)
Subject: Re: Max groups at 32?
In-Reply-To: <200206042118.g54LINc12880@www.hockin.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Jun 2002 23:40:46 +0200
Message-ID: <shs3cw2rach.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Tim Hockin <thockin@hockin.org> writes:

    >> Few months ago was release by me shadow package with some
    >> neccessary for this changes. From
    >> http://shadow.pld.org.pl/ChangeLog:

     > We have a patch floating around that enables unlimited group
     > membership at the kernel level, too.  We've never submitted it
     > because it was suggested that we were crazy and should just
     > bugger off.  If I thought it might be useful and acceptable, we
     > could perhaps make it available in a cleanish form.

Finally, the Linux *BSD cred patch also gets rid of that limit
(amongst other things). I haven't updated it since 2.5.3 (and it needs
breaking up into smaller patches), but it can still be found under

 http://www.fys.uio.no/~trondmy/src/2.5.3/linux-2.5.3-cred.dif

Cheers,
  Trond
