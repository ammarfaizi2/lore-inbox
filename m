Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311732AbSCXSYl>; Sun, 24 Mar 2002 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311760AbSCXSYb>; Sun, 24 Mar 2002 13:24:31 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:24460 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S311732AbSCXSYM>; Sun, 24 Mar 2002 13:24:12 -0500
Date: Sun, 24 Mar 2002 13:23:54 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pCdY-0006tY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203241322420.30005-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Alan ,  Is there any documentation for the 'new overcommit
	mode 2/3' functionaltiy ?  Tia ,  JimL

On Sun, 24 Mar 2002, Alan Cox wrote:
> > > At the point you hit OOM every possible heuristic is simply handwaving that
> > > will work for a subset of the user base. Fix the real problem and it goes
> > > away.
> > On the other hand - nobody is perfect and there can be such situations.
> My system cannot (short of a bug) go OOM. Thats what the new overcommit
> mode 2/3 ensures

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

