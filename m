Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWAGBP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWAGBP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAGBP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:15:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32202 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932668AbWAGBP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:15:58 -0500
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Morton Andrew Morton" <akpm@osdl.org>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CA@ssvlexmb2.amd.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Jan 2006 18:14:45 -0700
In-Reply-To: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CA@ssvlexmb2.amd.com> (Yinghai
 Lu's message of "Fri, 6 Jan 2006 16:35:09 -0800")
Message-ID: <m1psn43kl6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Thanks. You don't need Etherboot with IB later....
>
> How about the size of your first kernel and initrd? Are they in IDE
> Flash?

Yes.  It is a bproc system for LANL.  2 kernel monte finally broke 
so we did a quick switch kexec to get things moving.

Small initrd are a separate issue entirely.

Eric
