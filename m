Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTGCTx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTGCTx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:53:26 -0400
Received: from mailgate2.nau.edu ([134.114.96.59]:31122 "EHLO
	mailgate2.nau.edu") by vger.kernel.org with ESMTP id S265332AbTGCTxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:53:25 -0400
Date: Thu, 03 Jul 2003 13:01:34 -0700
From: Justin Pryzby <justinpryzby@users.sf.net>
Subject: "Will be removed in 2.4"
To: linux-kernel@vger.kernel.org
Message-id: <20030703200134.GA18459@andromeda>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.21, include/asm/io.h:51 says "Will be removed in 2.4".  Its
there in 2.5.74 as well.

I can understand why it would be in 2.5; the comment should say 2.6,
though.

Justin
