Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUHIOzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUHIOzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUHIOy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:54:29 -0400
Received: from [213.146.154.40] ([213.146.154.40]:48592 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266768AbUHIOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:51:27 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408091440.i79EeqrH010640@burner.fokus.fraunhofer.de>
References: <200408091440.i79EeqrH010640@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092063079.4383.5227.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 15:51:19 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 16:40 +0200, Joerg Schilling wrote:
> >From: David Woodhouse <dwmw2@infradead.org>
> 
> >On Mon, 2004-08-09 at 16:12 +0200, Joerg Schilling wrote:
> >> If you are right, why then is SuSE removing the warnings in cdrecord
> >> that are there to tell the user that cdrecord is running with insufficient 
> >> privilleges?
> 
> >Because those warnings are bogus, put there by someone who likes to
> >complain about things that are not _really_ a problem?
> 
> Try to inform yourself before sending wrong mails.....

Jrg, you are making a fool of yourself.

> People who use the official cdrecord know that they need to run cdrecord
> with root privilleges. People who run the bastardized version from SuSE
> don't know this and fail to write CDs.

Actually I run the bastardised version from another distro -- also as
myself rather than as root. With BurnFree enabled to ensure that buffer
underruns don't cause problems (not that they happen _anyway_), I see no
failures due to not running as root.

-- 
dwmw2

