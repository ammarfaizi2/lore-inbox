Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJ2C1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJ2C1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:27:49 -0500
Received: from corpmail.outblaze.com ([203.86.166.82]:9862 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S261872AbTJ2C1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:27:48 -0500
Date: Wed, 29 Oct 2003 10:27:15 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: Anybody has a pointer to int80/sysenter benchmark program
Message-ID: <20031029022715.GC29856@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.11; VAE: 6.22.0.1; VDF: 6.22.0.18; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am trying to find a benchmark program which can show the number of
cycles int80/sysenter take on various hardware. 

I found the following URL
http://colorfullife.com/~manfred/Linux-Kernel/old/sysenter/

Running it on Redhat Fedora with 2.6.0-test8, int80 works fine but I get
a segfault with sysenter (my understanding is that Fedora glibc is
sysenter aware)

Anybody has a pointer to such a benchmark program ?

Regards, Yusuf
-- 
If you're not using Firebird, you're not surfing the web 
   you're suffering it
http://www.mozilla.org/products/firebird/why/
