Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTKGWmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTKGW0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:34 -0500
Received: from smtp.infonegocio.com ([213.4.129.150]:23724 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S264422AbTKGPln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:41:43 -0500
Subject: Re: hard lockup with 2.6.0
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
To: linux-kernel@vger.kernel.org
Cc: miekg@atoom.net
Content-Type: text/plain
Message-Id: <1068219610.14200.6.camel@mir>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 07 Nov 2003 16:41:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm experiencing same hard lockups:

Machine (which seem stable until then) just hard locks without any prior
notice. It's a Pentium II 233, running 192KB of RAM (PC133).

I've ran memtest86 to no avail. Everything seems ok.
I've run badblocks, fsck'ed and dd'ed two entire hard disk without any
single error. I've done 24 runs of kernel compilation without any single
SIG11. Then (randomly) machine stops responding to everything. Sometimes
disk spin down.

As a side note, the machine acts as a NAT router running iptables and
I've had two corrupted files (one Windows Service pack, unistallable)
and one DivX file with errors. 

Hope that helps.

