Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270727AbRHKGaZ>; Sat, 11 Aug 2001 02:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270728AbRHKGaP>; Sat, 11 Aug 2001 02:30:15 -0400
Received: from zero.tech9.net ([209.61.188.187]:40200 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S270727AbRHKGaK>;
	Sat, 11 Aug 2001 02:30:10 -0400
Subject: [PATCH] 2.4.7-ac11: (Even more) Updated emu10k1
From: Robert Love <rml@tech9.net>
To: rui.p.m.sousa@clix.pt, alan@lxorguk.ukuu.org.uk
Cc: emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 11 Aug 2001 02:30:59 -0400
Message-Id: <997511467.7537.45.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated patch to the latest version of the emu10k1 driver is
available against 2.4.7-ac11.  This release is based on my patch that is
now in 2.4.8, but with Rui's fixes on top of that.

http://tech9.net/rml/linux/patch-rml-2.4.7-ac11-emu10k1-4

This is hopefully the codebase Rui wants.

See my previous thread or Rui's patch for more information.

Alan, applying this will bring us in sync with linus, satisfy my desire
for a newer driver, and merge in the maintainer's fixes.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

