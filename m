Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTEVRps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTEVRps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:45:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:31967 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262883AbTEVRpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:45:46 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.4056.136751.729309@napali.hpl.hp.com>
Date: Thu, 22 May 2003 10:58:48 -0700
To: Mike Galbraith <efault@gmx.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: web page on O(1) scheduler
In-Reply-To: <5.2.0.9.2.20030522181509.00cc4338@pop.gmx.net>
References: <16075.48579.189593.405154@napali.hpl.hp.com>
	<5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
	<16075.8557.309002.866895@napali.hpl.hp.com>
	<5.2.0.9.2.20030522181509.00cc4338@pop.gmx.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 22 May 2003 18:25:54 +0200, Mike Galbraith <efault@gmx.de> said:

  Mike> Out of curiosity, is someone hitting that with a real program?

Yes, it caused a failure in a validation program.  The test case is a
stripped-down version of the original program and, of course, doesn't
make much sense other than to demonstrate the scheduling problem.

	--david
