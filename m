Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUE2OrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUE2OrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUE2OrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:47:14 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265007AbUE2Oqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:46:35 -0400
Date: Sat, 29 May 2004 15:53:44 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405291453.i4TErifg000165@81-2-122-30.bradfords.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040529161247.A19214@electric-eye.fr.zoreil.com>
References: <20040529111616.A16627@electric-eye.fr.zoreil.com>
 <20040529115238.A17267@electric-eye.fr.zoreil.com>
 <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk>
 <20040529161247.A19214@electric-eye.fr.zoreil.com>
Subject: Re: Recommended compiler version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Francois Romieu <romieu@fr.zoreil.com>:
> John Bradford <john@grabjohn.com> :
> [...]
> > In my opinion, code that doesn't compile with 2.95.3 is broken - 2.95.3 is
> 
> If you are asking for technical details, please read the thread ending
> at: http://oss.sgi.com/projects/netdev/archive/2004-05/msg00440.html
> 
> [...]
> > Basically, 2.95.3 is something of a point of reference, so it only makes
> > sense to throw it out once we have a new point of reference.
> 
> It makes no sense to religiously recommended 2.95.3 if it is known broken.

The _code_ is broken if it doesn't compile with the recommended compiler, not
the compiler itself.

> If nobody comes with a better approach, I'll simply submit a patch to
> remove the 2.95.3 recommendation (+ #error for the driver as suggested by ak).

Please leave the recommendation unless it's being replaced by a new one.

John.
