Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWHNTqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWHNTqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWHNTqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:46:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53434 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932506AbWHNTqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:46:05 -0400
Message-ID: <44E0D2DB.7030003@zytor.com>
Date: Mon, 14 Aug 2006 12:45:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com> <20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com> <20060814194252.GC2519@in.ibm.com>
In-Reply-To: <20060814194252.GC2519@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
>>>
>> What about once the kernel is booted?
> 
> Sorry did not understand the question. Few more lines will help.
> 

Is this field intended to protect any kind of memory during the early 
boot phase of the kernel proper, or only the decompressor?

	-hpa

