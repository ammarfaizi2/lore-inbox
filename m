Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTBPT3a>; Sun, 16 Feb 2003 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBPT33>; Sun, 16 Feb 2003 14:29:29 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:33278 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267359AbTBPT32>; Sun, 16 Feb 2003 14:29:28 -0500
From: "Alvaro Barbosa G." <alvaro.barbosa-g@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: > > make: *** No rule to make target `2'.  Stop. when make bzImage
Date: Sun, 16 Feb 2003 19:39:21 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161939.21889.alvaro.barbosa-g@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the lack of info:

Errors happen during: 
make bzImage 
will add the error file bzI_err
the architecture is for i686
this happen also with phoebe kernel-2.4.20-2.48, i had this problem a few
days ago, so i upgraded gcc, cpp, glibc, rpm to the latest rawhide rpms 
15.2.03, but get the same error 'make No rule to make target '2''

alvaro

> > Hi,
> >
> >
> > kernel-2.5.61-1
> > gcc-3.2.2-1
> >
> > make: *** No rule to make target `2'.  Stop.
> >
> > Any ideas?
