Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUBENsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUBENse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:48:34 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9858 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265273AbUBENse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:48:34 -0500
Date: Thu, 5 Feb 2004 13:57:54 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402051357.i15Dvsrl002050@81-2-122-30.bradfords.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200402050825.58623.gene.heskett@verizon.net>
References: <200402050825.58623.gene.heskett@verizon.net>
Subject: Re: cdwriter /dev/hdc question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why is the kernel turning it off in the first place?

I think the error message is bogus, and that DMA is actually silently
re-enabled shortly afterwards, but I could be wrong.

John.
