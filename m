Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVCJISx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVCJISx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVCJISC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:18:02 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:42390 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262405AbVCJIQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:16:38 -0500
Date: Thu, 10 Mar 2005 17:16:51 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Dave Anderson <anderson@redhat.com>, gdb <gdb@sources.redhat.com>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1110430955.3574.11.camel@wks126478wss.in.ibm.com>
References: <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com> <1110430955.3574.11.camel@wks126478wss.in.ibm.com>
Message-Id: <20050310170857.C299.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using ELF format to construct dump information (registers, physical adress
range, and physical memory etc.) is OK. It's not bad idea.

But it is not necessary to indend to use a particular analysis tool.
Do simple.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

