Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTEUPFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 11:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEUPFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 11:05:13 -0400
Received: from palrel12.hp.com ([156.153.255.237]:44944 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262163AbTEUPFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 11:05:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.39093.200508.885460@napali.hpl.hp.com>
Date: Wed, 21 May 2003 08:18:13 -0700
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: web page on O(1) scheduler
In-Reply-To: <1053507692.1301.1.camel@laptop.fenrus.com>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
	<1053507692.1301.1.camel@laptop.fenrus.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 21 May 2003 11:01:33 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> On Wed, 2003-05-21 at 08:49, David Mosberger wrote:
  >>  I think the web pages should be most relevant to the HPTC (high
  >> performance technical computing) community, since this is the
  >> community that is most likely affected by some of the performance
  >> oddities of the O(1) scheduler.  Certainly anyone using OpenMP on
  >> Intel platforms (x86 and ia64) may want to take a look.

  Arjan> oh you mean the OpenMP broken behavior of calling
  Arjan> sched_yield() in a tight loop to implement spinlocks ?

Please have the courtesy of reading the web page before jumping to
conclusions.

	--david
