Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbTDGIJU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTDGIJT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:09:19 -0400
Received: from [65.214.160.163] ([65.214.160.163]:60569 "EHLO rimmer.65535.net")
	by vger.kernel.org with ESMTP id S263325AbTDGIJM (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:09:12 -0400
Date: Mon, 7 Apr 2003 09:20:28 +0100 (BST)
From: meyers_j@freeshell1.65535.net
X-X-Sender: meyers_j@rimmer.65535.net
To: linux-kernel@vger.kernel.org
Subject: Booting offsets
Message-ID: <Pine.LNX.4.44.0304070920010.6323-100000@rimmer.65535.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a 40GB harddisk . I copied four  8GB harddisks onto the 40GB harddisks using dd at offsets of 9GB.I know the exact offset where i copied onto the 40GB harddisk.
	The 8GB harddisks boot by themsevles ie they each have a partition table and linux kernel.
	The problem is that i have to boot these four harddisks seperately.I don't want to build partitions.Can i boot these images using offsets using lilo or grub. I mean i get a grub menu then i choose offset=9GB and i boot the second 8GB harddisk.
	Is it possible ?
Thank you

