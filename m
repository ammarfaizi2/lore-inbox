Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293460AbSCASBF>; Fri, 1 Mar 2002 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293462AbSCASAp>; Fri, 1 Mar 2002 13:00:45 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:50184 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293460AbSCASAi>; Fri, 1 Mar 2002 13:00:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 1 Mar 2002 10:03:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Chen <crimsun@email.unc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating
 O(1))
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx>
Message-ID: <Pine.LNX.4.44.0203011001030.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Dan Chen wrote:

> In response to Rik's post concerning a #define yield(), I've done a
> quick egrep over the 2.4.19-pre2 tree and modified as necessary. This is
> a strict search and replace. Thanks to Rik and Davide for assistance.
> Please correct me if I erred.

Feed it to Marcelo with a few lines of comment ( even if it's clear ).



- Davide


