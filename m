Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbTEBS5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTEBS5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:57:12 -0400
Received: from palrel12.hp.com ([156.153.255.237]:31121 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263111AbTEBS5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:57:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16050.49771.239186.329712@napali.hpl.hp.com>
Date: Fri, 2 May 2003 12:09:31 -0700
To: John Bradford <john@grabjohn.com>
Cc: mingo@redhat.com (Ingo Molnar), arjanv@redhat.com (Arjan van de Ven),
       davidel@xmailserver.org (Davide Libenzi),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com>
	<200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 2 May 2003 19:29:38 +0100 (BST), John Bradford <john@grabjohn.com> said:

  John> Slightly off-topic, but does anybody know whether IA64 or x86-64 allow
  John> you to make the stack non-executable in the same way you can on SPARC?

Not only "allow", but it's the default on ia64 linux.

	--david
