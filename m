Return-Path: <linux-kernel-owner+w=401wt.eu-S1161015AbXALHZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbXALHZd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbXALHZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:25:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39813 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161015AbXALHZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:25:32 -0500
Date: Thu, 11 Jan 2007 23:25:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,mm: hecuba/E-Ink fbdev driver
Message-Id: <20070111232522.491e57fb.akpm@osdl.org>
In-Reply-To: <1168586145.26496.35.camel@twins>
References: <20070111142427.GA1668@localhost>
	<20070111133759.d17730a4.akpm@osdl.org>
	<45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
	<1168586145.26496.35.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 08:15:45 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> How about implementing the sync_page() aop?

That got deleted in Jens's tree - the unplugging rework.
