Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTEMPEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTEMPEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:04:12 -0400
Received: from pat.uio.no ([129.240.130.16]:11980 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261387AbTEMPEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:04:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.3159.768256.81302@charged.uio.no>
Date: Tue, 13 May 2003 17:16:39 +0200
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513135756.GA676@suse.de>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<shswugvjcy9.fsf@charged.uio.no>
	<20030513135756.GA676@suse.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Dave Jones <davej@codemonkey.org.uk> writes:

     > I can still kill an NFS server in under a minute with fsx.

I'm more interested in hearing how the client fixes are coping.
i.e. is the client recovering properly if/when you restart the server
after such a crash?

Cheers,
  Trond
