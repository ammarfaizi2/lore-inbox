Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDQOJe>; Tue, 17 Apr 2001 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDQOJY>; Tue, 17 Apr 2001 10:09:24 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:55516 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S132625AbRDQOJO>; Tue, 17 Apr 2001 10:09:14 -0400
Date: Tue, 17 Apr 2001 16:09:10 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010417103900.C4385@kallisto.sind-doof.de>
Message-Id: <Pine.LNX.4.31.0104171603140.17288-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Andreas Ferber wrote:

[Extending the current signalling mechanism]

> The problem with this is that there is no single init. Most
> distribution run the same SysV init, but there are quite a few init
> replacements around. Should we really break all of them?

We don't break anything as long as noone sets the config option. People
who want to use this feature need a current init.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

