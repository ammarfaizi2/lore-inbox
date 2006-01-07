Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWAGAbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWAGAbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWAGAbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:31:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50121 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932296AbWAGAbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:31:03 -0500
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <20060103044632.GA4969@in.ibm.com> <20060106234803.GA67207@muc.de>
	<86802c440601061600p5cba2fbet61b2269cca3ab021@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Jan 2006 17:29:49 -0700
In-Reply-To: <86802c440601061600p5cba2fbet61b2269cca3ab021@mail.gmail.com> (Yinghai
 Lu's message of "Fri, 6 Jan 2006 16:00:44 -0800")
Message-ID: <m1bqyo518i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu <yinghai.lu@amd.com> writes:

> Eric,
>
> Do you try kexec with Nvidia ck804 based MB? it seems some one modify
> the mptable but not update the checksum ...

We've got a cluster using 2.6.14 booting over infiniband that
way.

Eric
