Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSL1UqB>; Sat, 28 Dec 2002 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSL1UqB>; Sat, 28 Dec 2002 15:46:01 -0500
Received: from havoc.daloft.com ([64.213.145.173]:17114 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265667AbSL1Up7>;
	Sat, 28 Dec 2002 15:45:59 -0500
Date: Sat, 28 Dec 2002 15:54:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: sexy sendfile?
Message-ID: <20021228205414.GA30388@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC from a post a month or so ago, Linus mentioned that current 2.5.x
no longer had deadlock issues for file->file sendfile, which leads me to
wonder aloud,

Does this mean file->file sendfile can now be official supported in 2.5.x?

And more interesting, [thus the CC to netdev]
can we support socket->socket sendfile?

	Jeff



