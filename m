Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUJ0F3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUJ0F3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUJ0F3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:26041 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbUJ0F3J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:29:09 -0400
Date: Tue, 26 Oct 2004 22:26:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, axboe@suse.de, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-Id: <20041026222650.596eddd8.akpm@osdl.org>
In-Reply-To: <87hdogvku7.fsf@barad-dur.crans.org>
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
	<87hdogvku7.fsf@barad-dur.crans.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud <matt@minas-morgul.org> wrote:
>
> Andrew Morton <akpm@osdl.org> disait dernièrement que :
> 
>  > If you have time, please restore dio-handle-eof.patch and then apply the
>  > below fixup, then retest.  Thanks.
> 
>  I had time to test this fix; it did not solve the problem. Whereas reverting
>  the complete dio-handle-eof.patch solved it.

bummer.  Can you send a super-simple means by which I can demonstrate the
problem?

Thanks.
