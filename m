Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUCJOeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUCJOeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:34:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32730 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262623AbUCJOem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:34:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thomas Horsten <thomas@horsten.com>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
Date: Wed, 10 Mar 2004 15:39:28 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.40.0403101258180.32012-200000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0403101258180.32012-200000@jehova.dsm.dk>
Cc: andre@linux-ide.org, <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403101539.28258.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday 10 of March 2004 14:07, Thomas Horsten wrote:
> I'll submit this again in the hope that it will be included.

I don't like the idea of having 2 drivers doing basically the same thing.
Please explain why we can't have one Medley software RAID driver?
[ Yes, I read http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/0156.html ]

Regards,
Bartlomiej

