Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753013AbWKGT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbWKGT4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbWKGT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:56:30 -0500
Received: from mis011-2.exch011.intermedia.net ([64.78.21.129]:5597 "EHLO
	mis011-2.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1752994AbWKGT43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:56:29 -0500
Message-ID: <4550E4DD.6070301@qumranet.com>
Date: Tue, 07 Nov 2006 21:56:13 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Yinghai Lu <yinghai.lu@amd.com>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
References: <454E4941.7000108@qumranet.com> <86802c440611070859g5bb3c8b0q6b05b4ef2782d682@mail.gmail.com>
In-Reply-To: <86802c440611070859g5bb3c8b0q6b05b4ef2782d682@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2006 19:56:28.0870 (UTC) FILETIME=[D077FE60:01C702A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu wrote:
> On 11/5/06, Avi Kivity <avi@qumranet.com> wrote:
>> - Windows 64-bit does not work.  That's also true for qemu, so it's
>>   probably a problem with the device model.
>
> Windows 64bit could work as guest with qemu latest cvs version.
>

That's good to know.  Once the next qemu version is released I'll merge 
it and re-test.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

