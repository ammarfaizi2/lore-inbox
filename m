Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUF3RU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUF3RU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUF3RUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:20:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:63979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266788AbUF3RPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:15:42 -0400
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200406301916.46181.bzolnier@elka.pw.edu.pl>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl>
	 <1088611825.1921.18.camel@gaston>
	 <200406301916.46181.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1088615544.1906.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 12:12:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What if we have a shared interrupt with another device ?
> 
> drive_is_ready() in ide-io.c:ide_intr() handles that.

Right, I figured that out about 5 minutes after sending the mail ;)

Ben.


