Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTKBQPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTKBQPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 11:15:15 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:10113 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261744AbTKBQPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 11:15:12 -0500
Date: Sun, 2 Nov 2003 17:15:10 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Quota Hash Abstraction 0.12
Message-ID: <20031102161510.GA22787@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone!

Quota Hash Abstraction provides more flexibility for all
kinds of quota extensions (for example mount point quota,
or quota domains), while retaining full compatibility to
the current quota hash implementation.

updated the patches for 2.4.23-pre8 and 2.6.0-test9 ...

you can get them at:
http://www.13thfloor.at/patches/patch-2.4.23-pre8-qh0.12.diff.bz2
http://www.13thfloor.at/patches/patch-2.6.0-test9-qh0.12.diff.bz2

QHA is available for 2.4.22 and 2.6.0, so it should be 
quite easy to give it a try ... so please if somebody does 
some performance checks on this code, send me a copy of 
the results ...

enjoy,
Herbert


