Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUG1SGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUG1SGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUG1SGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:06:25 -0400
Received: from host85.200-117-133.telecom.net.ar ([200.117.133.85]:51657 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S261239AbUG1SGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:06:23 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: reiser4, kallsyms_lookup, 2.6.7-mm7
Date: Wed, 28 Jul 2004 15:06:12 -0300
User-Agent: KMail/1.6.82
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

well, just out of curiosity (I wanted to play with reiser4) I've patched my 
2.6.7-mm7 tree; no rejects. But I get this:

*** Warning: "kallsyms_lookup" [fs/reiser4/reiser4.ko] undefined!

How do I get around that warning?

The patch was 
http://www.namesys.com/auto-snapshots/reiser4-2004.07.27-19.37-linux-2.6.7-mm7.diff.gz


Thanks in advance,
Norberto
