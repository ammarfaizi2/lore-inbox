Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264280AbTCXRUk>; Mon, 24 Mar 2003 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264318AbTCXRUc>; Mon, 24 Mar 2003 12:20:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62644 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264422AbTCXRTV>; Mon, 24 Mar 2003 12:19:21 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303241730.h2OHURb15849@devserv.devel.redhat.com>
Subject: Re: ide-scsi quirk.
To: davej@codemonkey.org.uk
Date: Mon, 24 Mar 2003 12:30:27 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <200303241642.h2OGg535008290@deviant.impure.org.uk> from "davej@codemonkey.org.uk" at Mar 24, 2003 04:41:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as mentioned a few weeks back, something similar to
> this went into 2.4 (I munged this one a bit).
> 
> It deals with the issue of DMA starting before the
> drive is ready iirc.

Thats the least of the 2.5 ide-scsi problems, but yes its
probably one to add
