Return-Path: <linux-kernel-owner+w=401wt.eu-S1751371AbWLQAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWLQAUM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWLQAUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 19:20:11 -0500
Received: from [85.204.20.254] ([85.204.20.254]:33410 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751371AbWLQAUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 19:20:10 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 19:20:09 EST
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: I-NEO
Date: Sun, 17 Dec 2006 02:13:18 +0200
Message-Id: <1166314399.7018.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I had filesystem data corruption with rtorrent with 2.6.19.
I tried recent git with Peter Zijlstra patch
http://lkml.org/lkml/2006/12/16/144 and it seems that the problem is
fixed.

Please CC as I am not subscribed to lkml.

Andrei

