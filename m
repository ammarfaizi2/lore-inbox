Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSHKKL5>; Sun, 11 Aug 2002 06:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHKKL5>; Sun, 11 Aug 2002 06:11:57 -0400
Received: from zamok.crans.org ([138.231.136.6]:19853 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S318243AbSHKKL5>;
	Sun, 11 Aug 2002 06:11:57 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       noflushd-devel@lists.sourceforge.net, sct@redhat.com
Subject: Re: [patch 4/12] tunable ext3 commit interval
References: <3D5464CF.DCD510D6@zip.com.au>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <3D5464CF.DCD510D6@zip.com.au> (Andrew Morton's message of
 "Fri, 09 Aug 2002 17:56:47 -0700")
Organization: Kabale Inc
Date: Sun, 11 Aug 2002 12:15:38 +0200
Message-ID: <m3u1m1itv9.fsf@neo.loria>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO En cette nuit striée d'éclairs du samedi 10 août 2002, vers 02:56,
Andrew Morton <akpm@zip.com.au> disait:

> The patch from Stephen Tweedie allows users to modify the journal
> commit interval for the ext3 filesystem.

Could this patch be officially backported to 2.4 to allow the use of
the flexible commit interval in noflushd ?
