Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFTJJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFTJJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:09:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:34375 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262494AbTFTJJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:09:08 -0400
Date: Fri, 20 Jun 2003 02:23:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-Id: <20030620022308.2afa8142.akpm@digeo.com>
In-Reply-To: <20030620090612.GA1322@ghanima.endorphin.org>
References: <20030620090612.GA1322@ghanima.endorphin.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2003 09:23:08.0347 (UTC) FILETIME=[8FD158B0:01C3370D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> wrote:
>
> If this bug is fixed, we can go ahead and add cryptoloop which is ready and
>  tested.

Does it use the crypto framework which is present in the 2.5 kernel?

If it does not then the cryptoloop implementation which you mention
is inappropriate for inclusion.

If it does then it would be nice to see the full patchset.
