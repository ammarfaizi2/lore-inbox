Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUIOWbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUIOWbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUIOWa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:30:26 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:59248 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267685AbUIOWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:30:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 15 Sep 2004 15:29:59 -0700
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 15 Sep 2004 09:30:42 -0700 (PDT)")
Message-ID: <52zn3rupw8.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Sep 2004 22:30:00.0058 (UTC) FILETIME=[89517DA0:01C49B73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, while we're on the subject of new sparse checks, could you give
a quick recap of the semantics of the new __leXX types (and what
__bitwise means to sparse)?  I don't think I've ever seen this stuff
described on LKML.

Thanks,
  Roland
