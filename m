Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUFKQQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUFKQQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUFKQQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:16:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264103AbUFKQP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:15:58 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [0/12]
Date: Fri, 11 Jun 2004 17:46:51 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111746.51513.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some pending minor fixes + more cleanups (i.e. start unifying 4 flavors of
IDE PIO code).  Fairly conservative update, I hope it will make its way into
2.6.7-final.

Bartlomiej

