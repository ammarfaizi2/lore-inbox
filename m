Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTA1PfW>; Tue, 28 Jan 2003 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTA1PfW>; Tue, 28 Jan 2003 10:35:22 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34224 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267376AbTA1PfV>; Tue, 28 Jan 2003 10:35:21 -0500
Date: Tue, 28 Jan 2003 16:44:37 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "mikep@linuxtr.net" <MikePhillips@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: [LEGAL] possible GPL problem in drivers/net/tokenring/3c359_microcode.h
Message-ID: <20030128154437.GC10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Unless I cannot read, drivers/net/tokenring/3c359_microcode.h seems to
hold microcode. Most other drivers appear to have moved their
microcode to /etc/somewhere and have a config option pointing to that
file.

It might be a good idea to follow that example, but IANAL.

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
