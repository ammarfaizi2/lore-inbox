Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWFXBXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFXBXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWFXBXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:23:17 -0400
Received: from mail.tbdnetworks.com ([204.13.84.99]:41151 "EHLO
	mail.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S1750717AbWFXBXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:23:17 -0400
Subject: Re: OOPS in UDF
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060623175033.664ddcce.akpm@osdl.org>
References: <20060615155828.GA14257@defiant.tbdnetworks.com>
	 <20060623175033.664ddcce.akpm@osdl.org>
Content-Type: text/plain
Organization: TBD Networks
Date: Sat, 24 Jun 2006 03:22:32 +0200
Message-Id: <1151112152.5824.277.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 17:50 -0700, Andrew Morton wrote:
> On Thu, 15 Jun 2006 08:58:28 -0700
> nkiesel@tbdnetworks.com (Norbert Kiesel) wrote:
> 
> > I just got an OOPS while copying between two loopback-mounted UDF filesystems.
> > One or both of the UDF file systems are corrupted (some files not readable by
> > root), but kernel should not OOPS anyway.
> > 
> > I get the corrupted file systems reliably by rsync'ing big directories onto the
> > UDF filesystem (while trying to prepare a backup DVD).  I saw the OOPS only once
> > so far.  The system continued to work after the OOPS.
> 
> Are you able to get a copy of one of these filesystem images up onto a
> server somewhere so others can reproduce the crash?

I will try to recreate them.  If i succeed, I will report back.

</nk>


