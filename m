Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTL3Lpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbTL3Lpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:45:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:52927 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265756AbTL3LpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:45:25 -0500
Date: Tue, 30 Dec 2003 09:36:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: James Bourne <jbourne@hardrock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
Message-ID: <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, James Bourne wrote:

> linux-2.4.23-ide-busy-race-fix.patch: Daniel Lux: Fix IDE busy-wait race

I screwed up the merge of this patch, you also want to apply "Fix IDE
busywait merge" (its the next changeset after this one).
