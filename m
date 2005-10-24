Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVJXRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJXRyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJXRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:54:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38623 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751199AbVJXRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:54:35 -0400
Date: Mon, 24 Oct 2005 13:54:34 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/5] crypto/sha1.c: code cleanup
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches provide code cleanup and performance improvements for 
crypto/sha1.c.  They are split up for easier auditing, along with 
relevant measurements.


Nicolas
