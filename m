Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWJTNC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWJTNC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWJTNC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:02:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:31979 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030247AbWJTNC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:02:58 -0400
Subject: Re: VCD not readable under 2.6.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c43b2e150610191039h504b6000u242cadf8d146de9@mail.gmail.com>
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
	 <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
	 <1161124732.5014.20.camel@localhost.localdomain>
	 <c43b2e150610190935tefd11eev510c7dee36c15a51@mail.gmail.com>
	 <1161276178.17335.100.camel@localhost.localdomain>
	 <c43b2e150610191039h504b6000u242cadf8d146de9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Oct 2006 14:05:45 +0100
Message-Id: <1161349545.26440.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 19:39 +0200, ysgrifennodd wixor:
> the point is the CD does NOT get read, neither by xine nor by any
> other known to me tool. I asked here because the kernel is the only
> source of any messages addressing the unplayability of the CD - all
> the others just hang - so it looks like a kernel issue, doesn't it?

No. It looks to me like an application problem from what has been posted
so far. Its hard to be sure however. Can you try 2.6.18.1 which fixed
one or two problems with CD handling that might be enough to have
confused Xine.

