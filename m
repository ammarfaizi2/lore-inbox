Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTDFPzD (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDFPzD (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:55:03 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:21632 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263023AbTDFPzC (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:55:02 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304061608.h36G8esJ000637@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] take 48-bit lba a bit further
To: axboe@suse.de (Jens Axboe)
Date: Sun, 6 Apr 2003 17:08:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030406155941.GO786@suse.de> from "Jens Axboe" at Apr 06, 2003 05:59:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A single 512KiB request will have a lower per-kb overhead
> with 48-bit lba than a single 128kb on 28-bit would.

Ah, OK, that's what I wasn't sure about.

John.
