Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUFSQVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUFSQVB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUFSQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:20:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264228AbUFSQP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [0/11]
Date: Sat, 19 Jun 2004 18:15:43 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406191806.48048.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patchkit prepares ide-taskfile.c for unification
of CONFIG_IDE_TASKFILE_IO=y, CONFIG_IDE_TASKFILE_IO=n
and flagged_* PIO handlers which should happen soon
- lets deal with "easier" changes first.

Bartlomiej

