Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131388AbRAHVfc>; Mon, 8 Jan 2001 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRAHVfX>; Mon, 8 Jan 2001 16:35:23 -0500
Received: from hera.cwi.nl ([192.16.191.1]:22448 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131388AbRAHVes>;
	Mon, 8 Jan 2001 16:34:48 -0500
Date: Mon, 8 Jan 2001 22:34:45 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101082134.WAA148016.aeb@texel.cwi.nl>
To: stefan@hello-penguin.com
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Calling pathconf with a symlink is not defined.

The Austin draft requires pathconf to follow symlinks.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
