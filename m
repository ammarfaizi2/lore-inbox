Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUCRPZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUCRPZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:25:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16811 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262689AbUCRPZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:25:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Modular IDE drivers
Date: Thu, 18 Mar 2004 16:32:54 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <405969F1.2050103@suse.de> <200403181558.07657.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403181558.07657.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181632.54952.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> cmd640.c may be hard to convert due to fact that this chipset
> doesn't support config write cycles (more details in cmd640.c).

Just in case anybody wonders wtf I was thinking about...
'dword' word is missing here.

