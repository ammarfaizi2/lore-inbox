Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTFQSuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTFQSun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:50:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33496 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264887AbTFQSuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:50:40 -0400
Date: Tue, 17 Jun 2003 11:58:56 -0700 (PDT)
Message-Id: <20030617.115856.55831769.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: aneesh.kumar@digital.com, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Newsgroups: fa.linux.kernel
Subject: Re: force_successful_syscall_return() buggy?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16111.25976.768140.306522@napali.hpl.hp.com>
References: <fa.gvpfoqi.ngk8p2@ifi.uio.no>
	<3EEEBB1F.70609@digital.com>
	<16111.25976.768140.306522@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 17 Jun 2003 12:01:12 -0700
   
   Personally, I'd consider such behavior a bug,

Me too.
