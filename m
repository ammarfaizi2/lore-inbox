Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTFLWHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTFLWHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:07:16 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:63160 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S265020AbTFLWHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:07:14 -0400
Subject: Re: [PATCH] Fix perfctr on x86_64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
In-Reply-To: <16104.63811.690286.78565@gargle.gargle.HOWL>
References: <1055454843.1043.21.camel@serpentine.internal.keyresearch.com>
	 <16104.63811.690286.78565@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1055456460.1043.25.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 15:21:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 15:05, mikpe@csd.uu.se wrote:

> Thanks. Did this happen in 2.5.70 or 2.5.70-bk? I don't remember
> seeing this change in the vanilla 2.5.70.

Oops, it's in Andi's most recent *post*-2.5.70 patch for x86_64.  Those
changes are in BK-current, so the version checks should be against
2.5.71, not 2.5.70.

	<b

