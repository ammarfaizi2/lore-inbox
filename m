Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbTLHLhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbTLHLhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:37:14 -0500
Received: from intra.cyclades.com ([64.186.161.6]:30693 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265391AbTLHLhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:37:12 -0500
Date: Mon, 8 Dec 2003 09:22:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: XFS merged in 2.4
Message-ID: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI

Christoph reviewed XFS patch which changed generic code, and it was
stripped down later to a set of changes which dont modify the code
behaviour (except for a few bugfixes which should have been included
separately anyway) and are pretty obvious.

So its that has been merged, along with fs/xfs/.



