Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267276AbUG1QJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267276AbUG1QJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUG1QHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:07:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48311 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267242AbUG1QGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:06:20 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, suparna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<20040728105455.GA11282@in.ibm.com>
	<1091011565.30404.0.camel@localhost.localdomain>
	<35040000.1091025526@[10.10.2.4]>
	<1091023585.30740.7.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 10:05:38 -0600
In-Reply-To: <1091023585.30740.7.camel@localhost.localdomain>
Message-ID: <m11xiw15il.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> A SHA signed standalone dumper is as safe as anything else if not safer.

Thanks having a signature or a checksum on the dumper
stored in memory is one piece of this puzzle that I keep
forgetting.  Checking the signature before we trust the code
is important.

Eric
