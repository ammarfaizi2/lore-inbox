Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUHTS1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUHTS1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbUHTSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:24:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268637AbUHTSQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:16:03 -0400
Date: Fri, 20 Aug 2004 14:15:40 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <20040820173124.GA11086@lkcl.net>
Message-ID: <Xine.LNX.4.44.0408201415300.23466-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Luke Kenneth Casson Leighton wrote:

>  i presume that that is without the xattr patch which adds extended
>  attributes to tmpfs?

Yes.

-- 
James Morris
<jmorris@redhat.com>


