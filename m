Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTHVRpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTHVRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:45:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5506 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263484AbTHVRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:45:22 -0400
Date: Fri, 22 Aug 2003 18:57:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308221757.h7MHv3uS000585@81-2-122-30.bradfords.org.uk>
To: hch@lst.de, torvalds@osdl.org
Subject: Re: [PATCH] fix the -test3 input config damages
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it worth it? I see EMBEDDED as more of a "STANDARD" thing - for people
> who don't care or know, that's a slight safety-net saying "this selects
> the things you take for grated".

I'm pretty sure that's not what it was originally intended to be, but
rather what it seems to have become.  On the other hand, your
described usage is probably more useful to the typical user.

Why not have DEVELOPER to implement the original intentions of
EMBEDDED?

John.
