Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEYKuT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEYKuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:50:19 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22145 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261827AbTEYKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:50:18 -0400
Date: Sun, 25 May 2003 13:09:23 +0100
From: john@grabjohn.com
Message-Id: <200305251209.h4PC9NBr000987@81-2-122-30.bradfords.org.uk>
To: arjanv@redhat.com
Subject: Re: [RFR] a new SCSI driver
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on common misunderstanding ; PATA != PIO mode ATA but Parallel ATA, as
> opposed to Serial ATA

Yes, Parallel ATA is what I was suggesting we moved in to a legacy driver
sometime during the 2.7 timescale.

John.
