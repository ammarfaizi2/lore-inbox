Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136272AbRD1AOv>; Fri, 27 Apr 2001 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136275AbRD1AOm>; Fri, 27 Apr 2001 20:14:42 -0400
Received: from chromium11.wia.com ([207.66.214.139]:10507 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136272AbRD1AOh>; Fri, 27 Apr 2001 20:14:37 -0400
Message-ID: <3AEA0C52.FA7CE1F1@chromium.com>
Date: Fri, 27 Apr 2001 17:18:26 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: X15 alpha release: as fast as TUX but in user space
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I'd like to announce the first release of X15 Alpha 1, a _user space_
web server that is as fast as TUX.

On my Dell 4400 with 2G of RAM and 2 933MHz PIII and NetGear 2Gbit NICs
I achieve about 2500 SpecWeb99 connections, with both X15 and
TUX (actually X15 is sligtly faster, some 20 connections more... ;)

Given the limitations of my experimental setup I'd like to ask if some
of you could help me testing my software on some higher end machines.
I'm interested to see what happens on 4-8 processors in terms of
scalability etc.

You can download X15 Alpha 1 from here:
http://www.chromium.com/X15-Alpha-1.tgz

The the README file in the tarball should contain sufficient information
to run the thing, I also included a support module for running the
SpecWeb benchmark.

TIA, ciao,

 - Fabio


