Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUKWVsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUKWVsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKWVno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:43:44 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:17024 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261415AbUKWVnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:43:01 -0500
Date: Tue, 23 Nov 2004 21:43:00 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: description of struct sockaddr
Message-ID: <20041123214300.GB2147@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

man netdevice talks about struct sockaddr, but neither describes it,
nor provides a link to descriptio, nor the "SEE ALSO" items
(ip(7), proc(7), rnetlink(7)) provide the necessary information.

"The hardware address is specified in a struct sockaddr".

Where is struct sockaddr specified?

Cl<
