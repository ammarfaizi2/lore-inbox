Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWBGJqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWBGJqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBGJqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:46:54 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:45644 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964825AbWBGJqx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:46:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QT3A2996MXsdNVW4lDcNt4ydlK1+SuTRDVLmrm+t3l48ufdvaAnk0UyWMDu1ePFlGCdqLIMK1lQmF0TdCNfZt4zeMl/0MxNrSK+I1FwzS5X++GXo4g+c3BnsrBeBzmqg7/BlH6K4REq33YQ9aZBJp/yysp50kIkbBegTndF5uxw=
Message-ID: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
Date: Tue, 7 Feb 2006 17:46:51 +0800
From: Yoseph Basri <yoseph.basri@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: KERNEL: assertion (!sk->sk_forward_alloc) failed
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel maillist,

I'm new member maillist.

Currently, I receive the warning log from my kernel.

Since update to
Linux  2.6.14.3 #1 SMP Fri Nov 25 20:20:05 SGT 2005 i686 GNU/Linux from 2.4,

I am getting the warning log:

kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
net/core/stream.c (279)
kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
net/ipv4/af_inet.c (148)

Any information about this issue, and how to solve this problem ?

Another server that i rolled back from 2.6.14 to 2.4 kernel and has no
warning again. is this bug from 2.6 kernel?

Thanks for your info.

YB
