Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUJCBJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUJCBJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 21:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUJCBJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 21:09:42 -0400
Received: from sa11.bezeqint.net ([192.115.104.25]:33210 "EHLO
	sa11.bezeqint.net") by vger.kernel.org with ESMTP id S267648AbUJCBJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 21:09:41 -0400
Date: Sun, 3 Oct 2004 04:10:56 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3 lost cdrom
Message-ID: <20041003021055.GA3227@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have lost cdrom support through scsi emulation, any ideas?
(its a burner, and drive detection with xcdroast in ide mode is
terrible, takes minutes).
