Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUE2R4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUE2R4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 13:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUE2R4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 13:56:55 -0400
Received: from ozlabs.org ([203.10.76.45]:25749 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264658AbUE2R4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 13:56:44 -0400
Date: Sun, 30 May 2004 03:53:14 +1000
From: Anton Blanchard <anton@samba.org>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040529175314.GA7023@krispykreme>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

> This patch is not the Lustre file system, with client file system,
> Lustre RPC, server code etc.  This patch would enable people to run
> Lustre with modules loading into unmodified kernels and this appears
> to be something vendors really would like to see.  FYI, at the moment
> Lustre is a just a little bit larger than NFS, comparing clients,
> servers, and rpc code for each (60K vs 80K lines of code).

Seems to me we really need to look at this in tandem with the filesystem
itself. Do you have a URL we can grab it from?

Have these patches undergone any siginifant test?

Anton
