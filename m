Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUCSMzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 07:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCSMzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 07:55:47 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:34311
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262935AbUCSMzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 07:55:44 -0500
Date: Fri, 19 Mar 2004 04:53:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: hpt366-0.37.patch.bz2 K.O.
Message-ID: <Pine.LNX.4.10.10403190449240.2569-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.25/hpt366-0.37.patch.bz2

Fixes fifo dma data corruption on RocketRaid404
Fixes native HPT372 detection/setup for HPT372/HPT372A/HPT372N

HPT372N's previous code seems kooky, but then again do not have specific
hardware rev in question.

Kind Regards,

Andre Hedrick
LAD Storage Consulting Group

