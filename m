Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRCPLL4>; Fri, 16 Mar 2001 06:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbRCPLLq>; Fri, 16 Mar 2001 06:11:46 -0500
Received: from mail.ayrix.net ([64.49.1.26]:24318 "EHLO mail.ayrix.net")
	by vger.kernel.org with ESMTP id <S130466AbRCPLLc>;
	Fri, 16 Mar 2001 06:11:32 -0500
Message-ID: <3AB1F4B7.E7B12A08@ayrix.net>
Date: Fri, 16 Mar 2001 05:10:47 -0600
From: Bob Martin <bmartin@ayrix.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2 and opl3sa2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for opl3sa2 seems to be broken with 2.4.2. Same configuration with
2.4.1 it loads fine. The obvious thing is that the driver looks to have had some
major rewrite. Other modules load ok, so it's probably not a kernel problem but
something specific to this module.

Anyone else seen this or have a solution ?
-- 

Bob Martin
