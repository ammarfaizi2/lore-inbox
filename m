Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTHTUDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTHTUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:03:10 -0400
Received: from pat.uio.no ([129.240.130.16]:45239 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262177AbTHTUDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:03:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16195.54251.109848.71364@charged.uio.no>
Date: Wed, 20 Aug 2003 13:02:51 -0700
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
In-Reply-To: <20030820215246.B3065@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com>
	<shszni499e9.fsf@charged.uio.no>
	<20030820192409.A2868@pclin040.win.tue.nl>
	<16195.49464.935754.526386@charged.uio.no>
	<20030820215246.B3065@pclin040.win.tue.nl>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andries Brouwer <aebr@win.tue.nl> writes:


     > It should be. But it isnt. I propose the following patch (with
     > whitespace damage):

Yup... That should fix it...

Cheers,
  Trond
