Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbTDKPqL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTDKPqL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:46:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12930 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264413AbTDKPqK (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 11:46:10 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111600.h3BG0D7X001499@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel hcking
To: wind@cocodriloo.com (Antonio Vargas)
Date: Fri, 11 Apr 2003 17:00:13 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       vicky@freebsdcluster.net (Vikram Rangnekar),
       linux-kernel@vger.kernel.org
In-Reply-To: <20030411153711.GE25862@wind.cocodriloo.com> from "Antonio Vargas" at Apr 11, 2003 05:37:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> John, you mean a "make clean && make bzImage" takes you only about 4
> minutes???

Yep.

Well, make distclean; cp /foo/bar/config .config; make oldconfig; make bzImage

> I would like to know more details about .config, machine specs,
> compiler and so on :)

That's on an Athlon XP 2200, 512 MB RAM, 7200 RPM disk, with a fairly
typical .config.

> And no doubt having enough RAM to cache all the tree is really good :)

Yep :-).

John.
