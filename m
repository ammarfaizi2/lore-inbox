Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWF0Qz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWF0Qz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWF0Qz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:55:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5560 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161208AbWF0Qz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:55:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [RFC][patch 1/4] Network namespaces: cleanup of dev_base list use
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m1odwguez3.fsf@ebiederm.dsl.xmission.com> <44A0D755.5090204@sw.ru>
	<m11wtaonqf.fsf@ebiederm.dsl.xmission.com> <44A149F5.2060204@sw.ru>
Date: Tue, 27 Jun 2006 10:54:45 -0600
In-Reply-To: <44A149F5.2060204@sw.ru> (Kirill Korotaev's message of "Tue, 27
	Jun 2006 19:08:37 +0400")
Message-ID: <m1hd26lesq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> This doesn't support anything. e.g. I caught quite a lot of bugs after Ingo
> Molnar, but this doesn't make his code "poor". People are people.
> Anyway, I would be happy to see the typo.

Look up thread.  You replied to the message where I commented on it.

There are two ways to argue this.
- It is the linux kernel development style to do small simple
  obviously patches that copy the maintainer of the code you are
  changing.
- Explain why that is the style.

The basic idea is that on a simple patch that is well described, it is
trivial to check and trivial to verify.

Eric
