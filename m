Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUK3BNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUK3BNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUK3BNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:13:33 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47017 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261918AbUK3BNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:13:31 -0500
Date: Tue, 30 Nov 2004 10:15:04 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
In-reply-to: <1101732313.2814.63.camel@laptop.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <43C4D67A05B46Dindou.takao@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <1101732313.2814.63.camel@laptop.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 13:45:13 +0100, Arjan van de Ven wrote:

>>
>> I think kexec-dump is not stable yet.
>
>Do you have any facts to back this up? Is your project more stable ?
>What is the success rate of dumps of diskdump ? How does that compare to
>kexec-dump under the same circumstances ?

Sorry, a word "stable" was not appropriate. I meant that kexec-dump was
under development yet. kexec-dump works well on i386/x86_64, but it is
in the development stage on other architectures.

>> I heard that kexec-dump of
>> some architecture (ex. ia64) had some problems and not worked.
>
>wouldn't it be better to then help finish that rather than making an
>alternative ? 

It is, if diskdump project just started now. But the basic code of
diskdump is almost completed. I think it is more efficient to enhance 
quality of diskdump than help kexec-dump.

Best Regards,
Takao Indoh
