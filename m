Return-Path: <linux-kernel-owner+w=401wt.eu-S1030251AbXAKKgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbXAKKgZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXAKKgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:36:25 -0500
Received: from smtp.nokia.com ([131.228.20.170]:30057 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030251AbXAKKgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:36:24 -0500
Subject: Re: kallsyms_lookup export in -mm
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20070108103417.5bb5af26.akpm@osdl.org>
References: <20070108133036.GA18681@infradead.org>
	 <20070108103417.5bb5af26.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 11 Jan 2007 12:35:03 +0200
Message-Id: <1168511703.26936.29.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 11 Jan 2007 10:35:03.0704 (UTC) FILETIME=[27655180:01C7356C]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::070111123329-122D4BB0-33EF7E2A/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 10:34 -0800, Andrew Morton wrote:
> On Mon, 8 Jan 2007 13:30:36 +0000
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > This beast definitly shouldn't be exported.  drivers/mtd/ubi/debug.c
> > should probably be just removed instead - it's an utter mess anyway.
> 
> I think that's happening.  Partially, at least.

This is fixed now.

Andrew, I'll be at LCA, so I apologize for being not very responsive in
advance.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

