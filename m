Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUEQAug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUEQAug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEQAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:50:36 -0400
Received: from hera.kernel.org ([63.209.29.2]:55199 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263640AbUEQAuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:50:35 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Date: Mon, 17 May 2004 00:49:53 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c8927h$5l3$1@terminus.zytor.com>
References: <20040511212625.28ac33ef.rddunlap@osdl.org> <m1wu3fy46w.fsf@ebiederm.dsl.xmission.com> <1084558463.9305.33.camel@agtpad> <m11xlmxw7m.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084754993 5796 127.0.0.1 (17 May 2004 00:49:53 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 17 May 2004 00:49:53 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m11xlmxw7m.fsf@ebiederm.dsl.xmission.com>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> Randy already mentioned it.  :)
> Making the list of at least attempted ports:
> 
> x86, ppc64, ia64, x86-64, ppc32
> 
> But x86 and ppc64 seem to have the most developer interest.
> 

It should probably be reserved on all architectures, unless the
architecture maintainers explicitly don't want to support it.

	-hpa
