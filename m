Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289361AbSAJJz6>; Thu, 10 Jan 2002 04:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSAJJzt>; Thu, 10 Jan 2002 04:55:49 -0500
Received: from mustard.heime.net ([194.234.65.222]:15249 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289361AbSAJJzm>; Thu, 10 Jan 2002 04:55:42 -0500
Date: Thu, 10 Jan 2002 10:55:39 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Fixing the vm or merging rmap into the official tree?
Message-ID: <Pine.LNX.4.30.0201101051310.21329-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After weeks of testing, knocking my head against all sorts of objects,
trying out other potential OSes etc. etc. ad. infinitum, I got the hint of
using the rmap patch to fix my problems with reading multiple large files
at once (see prevois thread with subject "[BUG] Error reading multiple
large files").

Will this problem be addressed in 2.4 or perhaps 2.[56] ?

My testing shows that the current vm can't handle high/non-standards load
efficiently. Isn't this something that clearly should be addressed?

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


