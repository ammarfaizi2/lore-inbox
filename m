Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSGINEt>; Tue, 9 Jul 2002 09:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSGINEs>; Tue, 9 Jul 2002 09:04:48 -0400
Received: from gw-fxb-in.genebee.msu.ru ([195.208.219.253]:61445 "EHLO
	libro.genebee.msu.su") by vger.kernel.org with ESMTP
	id <S315202AbSGINEr>; Tue, 9 Jul 2002 09:04:47 -0400
Date: Tue, 9 Jul 2002 17:09:18 +0400 (MSD)
From: Tim Alexeevsky <realtim@mail.ru>
X-X-Sender: <tim@zhuchka>
Reply-To: <realtim@mail.ru>
To: Alex Riesen <Alexander.Riesen@synopsys.com>
cc: Tim Alexeevsky <realtim@mail.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: File accessing.
In-Reply-To: <20020709114749.GB32293@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.4.33.0207091657110.1450-100000@zhuchka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today Alex Riesen wrote:

AR>On Tue, Jul 09, 2002 at 01:47:41PM +0400, Tim Alexeevsky wrote:
AR>>    But if this is the reason for this subproblem, there are some others
AR>> and they all seem to appear simultaneously. They all are the problems with
AR>> accessing files. And as long as I got the first problem I will have a
AR>> lots of them on different filesystems until I reboot the system (AFAIK).
AR>>    Maybe the reason is some damage in global filesystem handling. (Is that
AR>> VFS?)
AR>that's not the reason 8-) That are consequences.
   You mean that mistake in reiserfs lead to global filesystem error?
   I think it did not, because I didn't mount reiserfs before all those things
have started. And mounted it only later to find out some info on that
partition.

AR>Maybe upgrade the kernel as well? 2.4.19-rc1 seems to be quiet stable
AR>for me and there was some changes to reiserfs since 2.4.17.
   I think I would. As soon as I will get to the place where the
connection speed is more than 9600 and connection itself is stable... :-/

Good luck,

                                                         Tim

,-----------------------------------------------------------------------------.
|                Wakko of Borg: Heeeeeeellllllllo Collective!                 |
`-----------------------------------------------------------------------------'

