Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUAMQYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAMQYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:24:04 -0500
Received: from bgp01116707bgs.westln01.mi.comcast.net ([68.42.104.61]:8967
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S264358AbUAMQYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:24:03 -0500
Date: Tue, 13 Jan 2004 11:21:23 -0500
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org
Subject: dmesg gives me request_module fail 2.6.1
Message-Id: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

request_module: failed /sbin/modprobe -- net-pf-10. error = 65280


This is what dmesg returns, about three pages worth of those.  I just upgraded from 2.6.0 to 2.6.1.  Never had this problem before, changed nothing in kernel config, just did 'make oldconfig', and 'make bzImage'..  

??


