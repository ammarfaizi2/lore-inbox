Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbUAPJnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUAPJnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:43:23 -0500
Received: from gate.in-addr.de ([212.8.193.158]:32456 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265354AbUAPJm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:42:56 -0500
Date: Fri, 16 Jan 2004 10:31:20 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Scott Long <scott_long@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Proposed enhancements to MD
Message-ID: <20040116093120.GH22417@marowsky-bree.de>
References: <40033D02.8000207@adaptec.com> <40043C75.6040100@pobox.com> <20040113134107.A7646@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040113134107.A7646@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-13T13:41:07,
   Matt Domsch <Matt_Domsch@dell.com> said:

> > You sorta hit a bad time for 2.4 development.  Even though my employer 
> > (Red Hat), Adaptec, and many others must continue to support new 
> > products on 2.4.x kernels,
> Indeed, enterprise class products based on 2.4.x kernels will need
> some form of solution here too.

Yes, namely not supporting this feature and moving onwards to 2.6 in
their next release ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

