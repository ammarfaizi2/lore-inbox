Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFUNXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFUNXo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVFUNXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:23:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47531 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261450AbVFUNUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:20:52 -0400
Date: Tue, 21 Jun 2005 15:20:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
In-Reply-To: <42B80F40.8000609@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0506211515210.3728@scrub.home>
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home>
 <42B80AF9.2060708@drzeus.cx> <Pine.LNX.4.61.0506211451040.3728@scrub.home>
 <42B80F40.8000609@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Jun 2005, Pierre Ossman wrote:

> Should I extract the changes for bkbits and make a reversed patch?

No, go through the warnings, analyze each one and choose an appropriate 
solution. You might want to keep notes, which you can post with the 
changelogs, so one can reproduce, why a certain change was done.

bye, Roman
