Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUANEq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUANEq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:46:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:24035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266308AbUANEqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:46:21 -0500
Date: Tue, 13 Jan 2004 20:46:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 6/7 Add SO_PEERSEC socket option and
 getpeersec LSM hook.
Message-Id: <20040113204636.72471a0a.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0401132336560.9386-100000@thoron.boston.redhat.com>
References: <20040113161257.40f1ff16.davem@redhat.com>
	<Xine.LNX.4.44.0401132336560.9386-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Tue, 13 Jan 2004, David S. Miller wrote:
> 
> > I'm totally fine with this patch but I cannot apply it as it will not go in
> > cleanly without your previous SELINUX bits applied, please resend to me
> > when that stuff goes in.
> 
> It's in -mm2 now.  It could either be left there for merging to mainline,
> or Andrew could drop it and I can send you the patch after the rest of the
> -mm2 stuff ends up in bitkeeper.
> 

Yes, I'll merge it up along with all the other SELinux patches.
