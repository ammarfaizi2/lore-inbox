Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTAMCL4>; Sun, 12 Jan 2003 21:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTAMCL4>; Sun, 12 Jan 2003 21:11:56 -0500
Received: from havoc.daloft.com ([64.213.145.173]:61404 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267771AbTAMCLz>;
	Sun, 12 Jan 2003 21:11:55 -0500
Date: Sun, 12 Jan 2003 21:20:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [0/6]
Message-ID: <20030113022039.GF18756@gtf.org>
References: <15906.1154.649765.791797@charged.uio.no> <20030113021951.GE18756@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113021951.GE18756@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:19:51PM -0500, Jeff Garzik wrote:
> OTOH why not do all this authentication and stuff in userspace?

Please forgive me:  ENOCAFFEINE.  I re-read your mail...
