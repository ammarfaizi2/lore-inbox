Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTFDEh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 00:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTFDEh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 00:37:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7125 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262811AbTFDEhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 00:37:55 -0400
Date: Tue, 03 Jun 2003 21:47:30 -0700 (PDT)
Message-Id: <20030603.214730.08347437.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: niv@us.ibm.com, kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16093.30507.661714.676184@napali.hpl.hp.com>
References: <3EDD52F5.8090706@us.ibm.com>
	<20030603.202320.59680883.davem@redhat.com>
	<16093.30507.661714.676184@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 3 Jun 2003 21:35:55 -0700

   Is this where I get to plug httperf?  It triggered the bug reliably in
   less than 10 secs. ;-)

distcc was a reliable test case too...
