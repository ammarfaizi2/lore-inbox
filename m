Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUE3K35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUE3K35 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUE3K35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:29:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262006AbUE3K34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:29:56 -0400
Date: Sun, 30 May 2004 11:37:13 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405301037.i4UAbDVr000460@81-2-122-30.bradfords.org.uk>
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40B8A161.5040306@kegel.com>
References: <40B8A161.5040306@kegel.com>
Subject: Re: Recommended compiler version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Dan Kegel <dank@kegel.com>:
> I agree 2.6 should continue to support and compile correctly under gcc-2.95.3,
> even if that means working around compiler bugs.  By the time linux-2.7
> rolls around, I suspect nobody will mind if we drop 2.95.3 in favor
> of 3.4.x.

Especially as newer versions of glibc won't compile with 2.95.3 anymore - so
if you're building a system completely from source, a 3.x.x version of GCC
is more or less a necessity anyway.

John.
