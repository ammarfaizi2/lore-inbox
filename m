Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUBSPVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUBSPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:21:04 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41704 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267318AbUBSPUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 10:20:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Art Tevs <arti_tevs@yahoo.de>
Subject: Re: PROBLEM:
Date: Thu, 19 Feb 2004 16:26:30 +0100
User-Agent: KMail/1.5.3
References: <4034CDF1.4090405@yahoo.de>
In-Reply-To: <4034CDF1.4090405@yahoo.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191626.30521.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 15:53, Art Tevs wrote:
> 1. Initialisation of hda failes.
> 2. The compiled 2.6.3 (or 2.6.3-rc3 too) cannnot initialize hda.

<,.,,>

> The initialization failes on
> hda: max request size:128KiB
>
> after this the kernel hangs.

Thanks for report.  Does 2.6.2 work for you?

--bart

