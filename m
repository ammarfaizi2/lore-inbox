Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRGIOk5>; Mon, 9 Jul 2001 10:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRGIOkr>; Mon, 9 Jul 2001 10:40:47 -0400
Received: from blacksun.leftmind.net ([204.225.88.62]:41476 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id <S264461AbRGIOkn>; Mon, 9 Jul 2001 10:40:43 -0400
Date: Mon, 9 Jul 2001 10:40:43 -0400
From: Anthony DeBoer <adb@leftmind.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010709104043.A17563@leftmind.net>
In-Reply-To: <Pine.GSO.4.21.0107070727030.24836-100000@weyl.math.psu.edu> <9i73bg$psv$1@pccross.average.org> <3B471399.1D6BBED6@mandrakesoft.com> <01070719241107.22952@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Newsgroups: leftmind.lists.linux-kernel
In-Reply-To: <20010707233108.B10109@pcep-jamie.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
>(tar has a silly pad-to-multiple-of-512-byte per file rule, which is
>inappropriate for this).  GNU cpio creates cpio format just fine.

Tarballs are almost universally compressed, and that pad squishes fairly
well then.  Certainly in kernel-piggyback mode that step wouldn't get
omitted.

-- 
Anthony de Boer, curator, Anthony's Home for Aged Computing Machinery
<adb@leftmind.net>
