Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVAEQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVAEQEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVAEQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:03:26 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:55729 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262505AbVAEQAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:00:35 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200501051600.j05G0WhT023481@clem.clem-digital.net>
Subject: 2.6.10-bk8 fails compile -- drivers/video/fbmem.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 5 Jan 2005 11:00:32 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:

  CC      drivers/video/fbmem.o
drivers/video/fbmem.c: In function `fb_set_var':
drivers/video/fbmem.c:719: parse error before `int'
make[2]: *** [drivers/video/fbmem.o] Error 1

-- 
Pete Clements 
