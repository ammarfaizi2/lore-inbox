Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRKVNmz>; Thu, 22 Nov 2001 08:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279502AbRKVNmq>; Thu, 22 Nov 2001 08:42:46 -0500
Received: from dirac.dina.kvl.dk ([130.225.40.191]:38148 "EHLO
	dirac.dina.kvl.dk") by vger.kernel.org with ESMTP
	id <S279326AbRKVNmd>; Thu, 22 Nov 2001 08:42:33 -0500
Date: Thu, 22 Nov 2001 14:42:27 +0100 (CET)
From: "Thomas S. Iversen" <thomassi@dina.kvl.dk>
To: linux-kernel@vger.kernel.org
Subject: XIP linux?
Message-ID: <Pine.LNX.4.21.0111221437130.22919-100000@dirac.dina.kvl.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There

I have a wonderfull HP omnibook 600C lying around here. It is a monster
machine with a 486-50Mhz and 4Mb ram. The hdd system is based on pcmcia
harddrives but mine is long gone to lala-land (badblocks everywhere).

So I thought of installing a CompactFlash card with a complete linux
system on it. Because of wear on the flash part I have to do without
swap. And as I only have 4Mb ram on the system I have to conserve that
also. So a couple of questions:

1. Are there any patches for making linux run from a CF card?
2. Anybody know anyting about making a XIP linux disk? (all code stays on
the CF card, only datastructures and the like eat up the little memory I
have)?

Any hint, pointer, anything will be greatly appriciated :)

Regards Thomas, Denmark

