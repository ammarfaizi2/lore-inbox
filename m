Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUD0VFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUD0VFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUD0VFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:05:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:53893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264352AbUD0VFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:05:08 -0400
Date: Tue, 27 Apr 2004 14:05:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040427140507.Z21045@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <200404261736.47522.jbarnes@sgi.com> <20040426174102.S22989@build.pdx.osdl.net> <Pine.SGI.4.53.0404271552040.632984@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.53.0404271552040.632984@subway.americas.sgi.com>; from erikj@subway.americas.sgi.com on Tue, Apr 27, 2004 at 04:00:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Jacobson (erikj@subway.americas.sgi.com) wrote:
> I expect the "new" stuff uses the virtual filesystem interface and other
> things suggested by the API docs they have.

*nod*

> My first impression is that pagg itself could be used to implement parts of
> what ckrm is doing if they desired and not necessarily the other way around.

Guess the key point is that many folks are interested in some sort of
aggregate resource container.  QoS on virtual servers, make rlimit type
of limits acutally useful, your needs, etc.  Be nice to come from
common infrastructure.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
