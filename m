Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTJDW3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJDW3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:29:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60347 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262795AbTJDW3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:29:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][IDE] remove PDC-ADMA placeholders
Date: Sun, 5 Oct 2003 00:33:13 +0200
User-Agent: KMail/1.5.4
References: <200310040156.35902.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040156.35902.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310050033.13920.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 of October 2003 01:56, Bartlomiej Zolnierkiewicz wrote:
> [IDE] remove PDC-ADMA placeholders
>
> They do not contain any real code.

I forgot to mention that real code for PDC ADMA controller is in adma100.c
and that it needs fixing (forward porting 2.4.x changes).

--bartlomiej

