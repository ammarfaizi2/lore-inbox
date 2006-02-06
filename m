Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWBFIdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWBFIdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWBFIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:33:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65253 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750768AbWBFIde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:33:34 -0500
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Andrey Savochkin" <saw@sawoct.com>, devel@openvz.org
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 01:31:49 -0700
In-Reply-To: <43E38BD1.4070707@openvz.org> (Kirill Korotaev's message of
 "Fri, 03 Feb 2006 19:58:57 +0300")
Message-ID: <m1mzh4ubuy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> This patch introduces some abstract container/VPS kernel structure and tiny
> amount of operations on it.
>
> Patches following this one will be used for virtualization of some resources
> based on this container infrastructure, including those VPIDs patches I sent
> before.
>
> What is important here is that:
> - each VPS has unique ID
> - each process in kernel can belong to one VPS only

Next time could you please a diffstat for your patches,
Thanks

Eric
