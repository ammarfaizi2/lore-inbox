Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLUAPz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLUAPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:15:55 -0500
Received: from ping.ovh.net ([213.186.33.13]:57323 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S261827AbTLUAPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:15:54 -0500
Date: Sun, 21 Dec 2003 01:14:22 +0100
From: Octave <oles@ovh.net>
To: linux-kernel@vger.kernel.org
Subject: lot of VM problem with 2.4.23
Message-ID: <20031221001422.GD25043@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Since we use 2.4.23 we have lot of crash. I have no kernel panic.
All I can report is this kind of syslog's message:
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process rateup

Mysql doesn't like 2.4.23 either.
SQL Error : 1 Can't create/write to file '/tmp/#sql2ec_1acd2_2.MYI' (Errcode: 30)

It arrives on servers which need swap.

No problem with 2.4.22.

Thanks
Octave
