Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUBSRSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUBSRSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:18:10 -0500
Received: from verein.lst.de ([212.34.189.10]:32221 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267387AbUBSRSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:18:07 -0500
Date: Thu, 19 Feb 2004 17:47:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: root@chaos.analogic.com, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove MAKEDEV scripts from scripts/
Message-ID: <20040219164716.GA31314@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	root@chaos.analogic.com, akpm@osdl.org,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20040219161306.GA30620@lst.de> <Pine.LNX.4.53.0402191119480.520@chaos> <200402191751.16652.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191751.16652.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 05:51:16PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Thanks, for catching this!
> 
> Christoph, please remove MAKEDEV.ide references from Documentation/ide.txt 8).

I'll do when your patches are merged - before the chances to get into
merge conflicts with your patchkit are just too high.

