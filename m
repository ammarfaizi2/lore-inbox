Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUBGHKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 02:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUBGHKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 02:10:25 -0500
Received: from rrcs-sw-24-153-196-99.biz.rr.com ([24.153.196.99]:8065 "EHLO
	yoda.dummynet") by vger.kernel.org with ESMTP id S266492AbUBGHKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 02:10:24 -0500
Date: Sat, 7 Feb 2004 01:10:23 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Promise PDC20378 PATA support?
Message-ID: <20040207071023.GA2304@yoda.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Has anyone had any luck getting PATA working on Promise PDC20378
controllers in a 2.6.x kernel?  As far as I can determine from
looking at the drivers and at 2-month old postings to linux-kernel,
the sata_promise driver only handles the two SATA ports and not the
PATA port.  The Promise-supplied TX2plus driver works (with PATA
support) for 2.4.x but hasn't been updated for 2.6.x.

I fear the answer is still no, but I hate being limited to only 4
PATA devices when I've got 5 sitting in there :)

Thanks,
Dan Hopper
