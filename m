Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUBXRVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUBXRVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:21:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:3849 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262321AbUBXRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:21:20 -0500
Date: Tue, 24 Feb 2004 17:21:14 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Otto Solares <solca@guug.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <Pine.GSO.4.58.0402240935090.3187@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0402241720500.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But the goal is to replace these ioctl()s by sysfs, too, isn't it?

Yes. ioctl should DIE!!!!


