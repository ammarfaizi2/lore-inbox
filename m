Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCTLcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCTLcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWCTLcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:32:35 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:24316 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751119AbWCTLce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:32:34 -0500
Message-ID: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: Lindent and coding style
Date: Mon, 20 Mar 2006 19:32:29 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lindent script in linux kernel source.  It breaks long lines, but uses space instead of tab as indentation.  However, the codingstyle document also from the kernel source indicates no space is allowed for indentation.  Is there a fix for this problem?  Or the result from lindent(space indentation) is actually allowed in kernel source?  Thanks.

--
Leo Li
Freescale Semiconductor
 
LeoLi@freescale.com 

