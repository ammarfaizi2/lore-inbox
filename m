Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUELXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUELXDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUELXDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:03:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38890 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263033AbUELXDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:03:04 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: ppc64 HDIO_TASK_* ioctls 2.4, 2.6
Date: Thu, 13 May 2004 01:03:59 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200405122253.i4CMrR31014078@falcon10.austin.ibm.com>
In-Reply-To: <200405122253.i4CMrR31014078@falcon10.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405130103.59404.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 of May 2004 00:53, Doug Maxey wrote:
> On Thu, 13 May 2004 00:47:49 +0200, Bartlomiej Zolnierkiewicz wrote:
> >  HDIO_DRIVE_TASK is _always_ available
>
> Yes, indeed.  Move the line, or eliminate the conditionals entirely?

Just move the line.

Regards,
Bartlomiej

