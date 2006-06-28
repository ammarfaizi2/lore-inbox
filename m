Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423349AbWF1OW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423349AbWF1OW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423348AbWF1OW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:22:58 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:43702 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1423349AbWF1OW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:22:57 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FD1@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: Chu hanjin-r52514 <Hanjin.Chu@freescale.com>, linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Add mpc8360epb and QE support to powerpc
Date: Wed, 28 Jun 2006 22:22:51 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support to MPC8360E MDS-PB board into powerpc arch.  It provides generic QE API called qe_lib.  Other QE device drivers should use this library.  It also includes an UCC gigabit Ethernet driver using qe_lib; mtd mapping file to use jffs/jffs2 filesystem.

--
Leo Li
Freescale Semiconductor
 
LeoLi@freescale.com 
