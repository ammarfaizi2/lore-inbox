Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUDTABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUDTABD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUDTABC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:01:02 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:34433 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261326AbUDTABB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:01:01 -0400
Subject: Re: [PATCH 2.6.6rc1-mm1] NFS sysctlized - readahead tunable
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082410183.19241.12.camel@bluerhyme.real3>
References: <1082407753.18853.12.camel@bluerhyme.real3>
	 <1082408907.3360.14.camel@lade.trondhjem.org>
	 <1082410183.19241.12.camel@bluerhyme.real3>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082419262.3360.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 20:01:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 17:29, Fabian Frederick wrote:
> But hey ! "I'm an absolute beginner" :) Maybe you and Andrew can tell me
> what to do with this ugly patch ;) e.g. no sysctl.h -> include stuff in
> inode.c ...

Yes.
