Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSG3Opy>; Tue, 30 Jul 2002 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSG3Opx>; Tue, 30 Jul 2002 10:45:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26637 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318308AbSG3Opx>; Tue, 30 Jul 2002 10:45:53 -0400
Date: Tue, 30 Jul 2002 10:43:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: martin@dalecki.de
cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
In-Reply-To: <3D3AF6E0.2040107@evision.ag>
Message-ID: <Pine.LNX.3.96.1020730103928.4042C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Marcin Dalecki wrote:

> I strongly oppose OSes with mutating semantics and don't like the
> "plugin" idea at all therefore.

I don't think that's the case, it's a little hard to say modules are a
plus and plugins are evil. This is not the core of the filesystem being
plugged, at least I hope not, but features which might have a new
implementation, or which may not be ready at the freeze. Think PAM for
filesystems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

