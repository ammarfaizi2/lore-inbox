Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTD3Q7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbTD3Q7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:59:46 -0400
Received: from h-66-134-11-58.CHCGILGM.covad.net ([66.134.11.58]:64008 "EHLO
	miniborg.vocalabs.com") by vger.kernel.org with ESMTP
	id S262232AbTD3Q7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:59:45 -0400
Date: Wed, 30 Apr 2003 11:11:54 -0500 (CDT)
From: Daniel Taylor <dtaylor@vocalabs.com>
To: linux-kernel@vger.kernel.org
Subject: Boot failure, VIA chipset.
Message-ID: <Pine.LNX.4.44.0304301108240.7276-100000@dtaylor.vocalabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a KT400-based system that will not boot the 2.5 series kernels.

It fails with a hard lock immediately after the video mode query when
VGA=ask is set in /etc/lilo.conf.

If anyone else is working on this contact me, otherwise I'll post
my results when I get it working.

-- 
Daniel Taylor        VP Operations and Development   Vocal Laboratories, Inc.
dtaylor@vocalabs.com   http://www.vocalabs.com/        (952)941-6580x203

