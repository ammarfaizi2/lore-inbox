Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUE2N3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUE2N3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUE2N3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:29:20 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264836AbUE2NXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:23:41 -0400
Date: Sat, 29 May 2004 14:30:43 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040529115238.A17267@electric-eye.fr.zoreil.com>
References: <20040529111616.A16627@electric-eye.fr.zoreil.com>
 <20040529115238.A17267@electric-eye.fr.zoreil.com>
Subject: Re: Recommended compiler version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Francois Romieu <romieu@fr.zoreil.com>:
> Francois Romieu <romieu@fr.zoreil.com> :
> [...]
> 
> I forgot to mention: 2.95.3 does not compile correctly the 2.6.6 r8169
> driver.
> 
> The archive does not make clear what should be used. The whole 2.95.[234]
> family seems flaky. :o/

In my opinion, code that doesn't compile with 2.95.3 is broken - 2.95.3 is
still the recommended compiler, and although various developers have been
using 3.x.x versions for a long time, I haven't been aware of any efforts
to test a specific 3.x.x version of GCC over a wide range of kernels.

Basically, 2.95.3 is something of a point of reference, so it only makes
sense to throw it out once we have a new point of reference.

John.
