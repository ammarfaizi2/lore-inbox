Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTE0K6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTE0K6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:58:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263235AbTE0K6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:58:40 -0400
Date: Tue, 27 May 2003 12:11:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, matthew@wil.cx,
       parisc-linux@parisc-linux.org
Subject: Re: [patch] kill lvm from parisc
Message-ID: <20030527111153.GD15709@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305262220.h4QMKo712570.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200305262220.h4QMKo712570.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 12:20:50AM +0200, Andries.Brouwer@cwi.nl wrote:
> CONFIG_BLK_DEV_LVM is gone, but there is still some associated code.
> This is the parisc part.

it's already gone from the parisc tree and will be picked up whenever
linus gets round to releasing 2.5.70 and we submit a patch.  please stop
resending.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
