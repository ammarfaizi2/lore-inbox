Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHGUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHGUUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUHGUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 16:20:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44965 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264299AbUHGUUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 16:20:15 -0400
Date: Sat, 7 Aug 2004 16:25:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-rc6
Message-ID: <20040807192549.GA26893@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the last -rc, fixing a couple of typos to the 
big file offset patch from -rc5.

-final will be out in a couple of hours, now for real.

Summary of changes from v2.4.27-rc5 to v2.4.27-rc6
============================================

Geert Uytterhoeven:
  o Fix net/atm/br2684.c file offset patch

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc6

Mikael Pettersson:
  o drivers/macintosh/nvram.c typo

