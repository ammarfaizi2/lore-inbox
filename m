Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTEJMBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 08:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbTEJMBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 08:01:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264058AbTEJMBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 08:01:14 -0400
Date: Sat, 10 May 2003 05:12:33 -0700 (PDT)
Message-Id: <20030510.051233.112594579.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: qla1280 mem-mapped I/O fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16060.58322.808144.819886@napali.hpl.hp.com>
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
	<1052566211.22636.1.camel@rth.ninka.net>
	<16060.58322.808144.819886@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Sat, 10 May 2003 04:34:42 -0700

   >>>>> On 10 May 2003 04:30:11 -0700, "David S. Miller" <davem@redhat.com> said:
   
     DaveM> David, you absolute MAY NOT pass this:
   
   Me?  It's the driver that's doing it! ;-)
   
It won't do it until your changes :-)
