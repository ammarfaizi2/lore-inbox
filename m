Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSAFNOH>; Sun, 6 Jan 2002 08:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSAFNN5>; Sun, 6 Jan 2002 08:13:57 -0500
Received: from [217.9.226.246] ([217.9.226.246]:38785 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288787AbSAFNNq>; Sun, 6 Jan 2002 08:13:46 -0500
To: Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
In-Reply-To: <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
Date: 06 Jan 2002 15:13:51 +0200
Message-ID: <87n0zraagg.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@suse.de> writes:
Dave> It'd be nice to see all these patches reducing this struct consolidated,
Dave> right now they're all ifdefing different bits with different names..

They're pretty much independent of each other and, IMHO, having them
as a single large dropping^h^h^h^h is not the preferred way of
submitting patches.

Regards,
-velco


