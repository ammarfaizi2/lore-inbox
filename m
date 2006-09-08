Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWIHVpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWIHVpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWIHVpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:45:41 -0400
Received: from nef2.ens.fr ([129.199.96.40]:8965 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751196AbWIHVpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:45:40 -0400
Date: Fri, 8 Sep 2006 23:45:35 +0200
From: David Madore <david.madore@ens.fr>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908214535.GA877@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr> <20060907230245.GB21124@sergelap.austin.ibm.com> <20060908010802.GA14770@clipper.ens.fr> <20060908013136.GA20535@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908013136.GA20535@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 23:45:35 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 08:31:36PM -0500, Serge E. Hallyn wrote:
> Do you have a little testsuite you've run which you could make available
> someplace?  Or a few test programs you could toss into a tarball and
> call a testsuite?  :)

<URL: ftp://quatramaran.ens.fr/pub/madore/newcaps/testsuite/ >

It doesn't test everything, though, and it's pretty ugly.  It's meant
for version 0.4.2 of the patch.

> Could you cc: the lsm list (linux-security-module@vger.kernel.org)?
> I'd particularly have Chris Wright give some comment as he's spent a
> lot of time looking at capabilities.

Done.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
