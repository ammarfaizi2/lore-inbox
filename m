Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292421AbSBUPMM>; Thu, 21 Feb 2002 10:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292439AbSBUPMI>; Thu, 21 Feb 2002 10:12:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292421AbSBUPLu>;
	Thu, 21 Feb 2002 10:11:50 -0500
Message-ID: <3C750E33.363D414F@mandrakesoft.com>
Date: Thu, 21 Feb 2002 10:11:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@dplanet.ch>
CC: Giacomo Catenazzi <cate@debian.org>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.fsgrt4v.1bngh9t@ifi.uio.no> <fa.hp69onv.i7qtq3@ifi.uio.no> <3C74FF03.8070502@debian.org> <3C7503B1.E7CA83AA@mandrakesoft.com> <3C7506B5.20103@dplanet.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> But for kernel/, arch/ there are no simple way to tell:
> "this makefile rule belong to this configuration".

Sure you can.  You can generate makefiles from any source you wish... 
kernel/* and mm/* are actually easy examples, arch/* is much more
difficult.

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
