Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUHPPYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUHPPYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267750AbUHPPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:24:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267702AbUHPPUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:20:13 -0400
Date: Mon, 16 Aug 2004 11:19:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <019201c48374$09efc510$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Kaigai Kohei wrote:

> Is removing direct reference to AVC-Entry approach acceptable?
> 
> I'll try to consider this issue further.

Sure, if you can make it work without problems.



- James
-- 
James Morris
<jmorris@redhat.com>


