Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbTGJPbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbTGJPbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:31:08 -0400
Received: from pat.uio.no ([129.240.130.16]:24468 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S269372AbTGJPbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:31:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.35360.440940.490089@charged.uio.no>
Date: Thu, 10 Jul 2003 17:45:36 +0200
To: Jamie Lokier <jamie@shareable.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
In-Reply-To: <20030710153557.GD29113@mail.jlokier.co.uk>
References: <20030710053944.GA27038@mail.jlokier.co.uk>
	<16141.15245.367725.364913@charged.uio.no>
	<20030710150012.GA29113@mail.jlokier.co.uk>
	<16141.32852.39625.891724@charged.uio.no>
	<20030710153557.GD29113@mail.jlokier.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > all the original requests are getting replies.

OK. That *is* definitely a bug... Let me ponder a bit. I'm working
through that logic right now...

Cheers,
  Trond
