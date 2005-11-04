Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbVKDGce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVKDGce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVKDGce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:32:34 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:1467 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1161083AbVKDGcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:32:33 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 4 Nov 2005 06:32:33 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "ambat sasi nair" <sasin@iname.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 04 Nov 2005 14:32:33 +0800
Subject: mmc_block.c - cmd24/25 do not expect r1b
X-Originating-Ip: 203.125.115.98
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20051104063233.3FA7183C02@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

just for the reference of any1 working on the mmc/sd driver for linux - write block commands (24/25) expect r1 and not r1b as coded in the mmc_block.c.

best regards,
sasi


-- 
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/

