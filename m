Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFZTKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFZTKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:10:49 -0400
Received: from palrel10.hp.com ([156.153.255.245]:51646 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262530AbTFZTKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:10:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16123.18562.260544.636726@napali.hpl.hp.com>
Date: Thu, 26 Jun 2003 12:24:50 -0700
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel patch release checklist available
In-Reply-To: <16122.53870.710841.141793@wombat.chubb.wattle.id.au>
References: <16122.53870.710841.141793@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 26 Jun 2003 21:01:02 +1000, Peter Chubb <peter@chubb.wattle.id.au> said:

  Peter> After being burnt a few times in forgetting something that I
  Peter> should have done when releasing a patch against the kernel,
  Peter> I've created a Kernel Patch Release Checklist at

  Peter> http://www.gelato.unsw.edu.au/IA64wiki/PatchReleaseChecklist

  Peter> If you want to you can add new stuff I haven't thought of to
  Peter> this list: but you need to register on the Wiki to do so.

Good stuff!

You might also want to mention that the patch should apply with "patch
-p1".

	--david
