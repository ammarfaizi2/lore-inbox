Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbTFLKY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbTFLKY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:24:27 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:31361 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264803AbTFLKY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:24:26 -0400
Date: Thu, 12 Jun 2003 11:45:33 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306121045.h5CAjXTE001313@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, lode_leroy@hotmail.com
Subject: Re: Q: how to run linux in a diskimage on NTFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to run linux on an embedded system that does
> not have a CDROM or FLOPPY, so the only possibility
> is to go over the network.

Why not use a boot rom in a network card, and have the kernel
image retrieved over the network, then put the root FS on NFS?

John.
