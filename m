Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUD3Jkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUD3Jkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUD3Jkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:40:43 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:10368 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263003AbUD3Jkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:40:42 -0400
Date: Fri, 30 Apr 2004 19:39:19 +1000
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Message-ID: <20040430093919.GA2109@zip.com.au>
References: <20040429234258.GA6145@zip.com.au> <200404300208.32830.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300208.32830.bzolnier@elka.pw.edu.pl>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 02:08:32AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Probably your drive needs mod15write quirk. please try this.
> 
> [PATCH] sata_sil.c: ST3200822AS needs MOD15WRITE quirk

Didn't work. Still hangs rather well. :/

-- 
    Red herrings strewn hither and yon.
