Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWJQQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWJQQYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJQQYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:24:40 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:18588 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751277AbWJQQYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:24:40 -0400
Date: Tue, 17 Oct 2006 18:23:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc2: known unfixed regressions (v2)
Message-ID: <20061017162323.GA6467@aepfle.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061017155934.GC3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061017155934.GC3502@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, Adrian Bunk wrote:

> Subject    : monitor not active after boot
> References : http://lkml.org/lkml/2006/10/5/338
> Submitter  : Olaf Hering <olaf@aepfle.de>
> Caused-By  : Antonino Daplas <adaplas@pol.net>
>              commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
> Status     : unknown

The nvidiafb change was removed again. I will see if I can figure out
why the EDID is lost.

