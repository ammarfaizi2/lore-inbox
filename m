Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVASN1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVASN1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVASN1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:27:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39364 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261717AbVASN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:27:52 -0500
Date: Wed, 19 Jan 2005 08:06:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-rc4
Message-ID: <20050119100647.GB2240@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the fourth release candidate.

It reverts the root mount retry patch for USB/special devices, this is 
going to get fixed cleanly on v2.6.

And updates the i386 defconfig.

v2.4.29 announcement should follow shortly


Summary of changes from v2.4.29-rc3 to v2.4.29-rc4
============================================

Marcelo Tosatti:
  o Cset exclude: solar@openwall.com|ChangeSet|20041218011100|24870
  o Changed VERSION to 2.4.29-rc4
  o Update i386 defconfig

