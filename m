Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266735AbUF3Pc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266735AbUF3Pc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUF3P3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:29:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266709AbUF3PZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [0/9]
Date: Wed, 30 Jun 2004 17:23:37 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301723.37659.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Unification of CONFIG_IDE_TASKFILE_IO=y|n and "flagged"
PIO handlers with a lot of fixes in the process.

Bartlomiej

