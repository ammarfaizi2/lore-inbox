Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUANEjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUANEjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:39:13 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:17415 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266291AbUANEjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:39:13 -0500
Date: Tue, 13 Jan 2004 23:39:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 6/7 Add SO_PEERSEC socket option and getpeersec
 LSM hook.
In-Reply-To: <20040113161257.40f1ff16.davem@redhat.com>
Message-ID: <Xine.LNX.4.44.0401132336560.9386-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, David S. Miller wrote:

> I'm totally fine with this patch but I cannot apply it as it will not go in
> cleanly without your previous SELINUX bits applied, please resend to me
> when that stuff goes in.

It's in -mm2 now.  It could either be left there for merging to mainline,
or Andrew could drop it and I can send you the patch after the rest of the
-mm2 stuff ends up in bitkeeper.


- James
-- 
James Morris
<jmorris@redhat.com>


