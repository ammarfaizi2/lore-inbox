Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGLTlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGLTlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUGLTlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:41:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40321 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262062AbUGLTj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:39:27 -0400
Date: Mon, 12 Jul 2004 21:33:49 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Slowly update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040712213349.A2540@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A serie of patches is available for at:
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7

It contains 12 patches and applies against 2.6.7-mm7. The patches are
commented. The comments are partly taken from the cvs log by Pavel Roskin.

Tarball available at:
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm7/orinoco.tar.bz2

Please review/comment/suggest a target to patch-bomb.

The remaining 30~35 patches are on the way.

If nobody minds, I'll move the thread to netdev.

--
Ueimor
