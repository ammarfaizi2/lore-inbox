Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311281AbSCQDib>; Sat, 16 Mar 2002 22:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311282AbSCQDiV>; Sat, 16 Mar 2002 22:38:21 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:18187 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311281AbSCQDiM>; Sat, 16 Mar 2002 22:38:12 -0500
Date: Sun, 17 Mar 2002 04:37:26 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Petko Manolov <pmanolov@lnxw.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: debugging eth driver 
In-Reply-To: <25257.1016329003@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0203170435080.12507-100000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Keith Owens wrote:

> On Sat, 16 Mar 2002 10:52:10 -0800, 
> Petko Manolov <pmanolov@lnxw.com> wrote:
> >Alan Cox wrote:
> >>>How am i supposed to get a feedback from the upper layers?
> >> 
> >> Keep an eye on /proc/net/snmp
> >
> >It isn't very readable format..  Any other way or i have to
> >read the code and see what the messages mean?
> 
> Quick and dirty script to neatly format /proc/net/snmp.  BTW, there is
> a mismatch in the ICMP list on 2.4.17, 26 headers and 27 values :(.

BTW. I dont't know how it looks in 2.4.x but in 2.2.x format
/proc/net/snmp and /proc/net/snmp6 is diffrent. Is it bug or feacture ? :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

