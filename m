Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTEZVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTEZVeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:34:16 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4482 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262285AbTEZVeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:34:15 -0400
Date: Mon, 26 May 2003 22:53:34 +0100
From: john@grabjohn.com
Message-Id: <200305262153.h4QLrYVN001135@81-2-122-30.bradfords.org.uk>
To: marcelo@conectiva.com.br, willy@w.ods.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > People often prefer "here is -rcxx-acxx, which my EPIA now fully
> > supports" to "here is -rcxx, please test it extensively".

> I dont understand what you mean.

Smaller, more frequent patches, have the advantage of getting more widespread
testing of a common codebase - the problem with testing individual patchsets
separately is that it's quite possible that with only a few people testing any
particular combination, bugs appear in a large -pre or -rc patchset, and prevent
others from testing the rest of that patchset easily.  A -pre every week, even
if it only had a few changes, would get more bug reports in, (in my opinion).

John.
