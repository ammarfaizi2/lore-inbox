Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271245AbTHCVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271255AbTHCVp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:45:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6273 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S271245AbTHCVp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:45:58 -0400
Date: Sun, 3 Aug 2003 22:56:27 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308032156.h73LuRLp000609@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, john@grabjohn.com
Subject: Re: issues with any ac sources, and 2.6
Cc: bbeutner@comcast.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For the AC kernels, try backing out just the IDE patches, and see if
> > that allows you to boot.
>
> I dont think 2.6-ac has any IDE patches. Its a fair collection of driver
> stuff so it could be hitting one of the driver things easily enough

It's 2.4-ac that he's testing.  The 2.6 non-boot issue is separate.

John.
