Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbTCGOa5>; Fri, 7 Mar 2003 09:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbTCGOa5>; Fri, 7 Mar 2003 09:30:57 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:32773 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S261610AbTCGOaz>; Fri, 7 Mar 2003 09:30:55 -0500
Date: Fri, 7 Mar 2003 08:43:57 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030307084357.A10344@discworld.dyndns.org>
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <200303070913.h279Cpu07949@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303070913.h279Cpu07949@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Mar 07, 2003 at 11:10:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> Anything built static against glibs tends to be 400K+.

So don't use glibc.  Link staticly against diet-libc or klibc.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
