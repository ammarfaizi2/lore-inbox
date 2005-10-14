Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJNNed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJNNed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 09:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVJNNed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 09:34:33 -0400
Received: from nammatj.nsc.liu.se ([130.236.101.75]:42125 "EHLO
	nammatj.nsc.liu.se") by vger.kernel.org with ESMTP id S1750745AbVJNNec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 09:34:32 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jakob Oestergaard <jakob@unthought.net>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Cache invalidation bug in NFS v3 - trivially reproducible
References: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
	<1129242855.8435.32.camel@lade.trondhjem.org>
From: Leif Nixon <nixon@nsc.liu.se>
Date: Fri, 14 Oct 2005 15:34:25 +0200
In-Reply-To: <1129242855.8435.32.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Thu, 13 Oct 2005 18:34:14 -0400")
Message-ID: <m364s0mdcu.fsf@nammatj.nsc.liu.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> Does the attached patch help?

Yes, it does indeed seem to solve the problem.

Thanks!

-- 
Leif Nixon                       -            Systems expert
------------------------------------------------------------
National Supercomputer Centre    -      Linkoping University
------------------------------------------------------------
